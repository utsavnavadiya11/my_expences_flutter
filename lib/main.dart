import 'package:flutter/material.dart';
import './Widgets/chart.dart';
import './models/transaction.dart';
import './Widgets/new_transaction.dart';
import './Widgets/trasnsactionlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> transaction = [];

  List<Transaction> get recentTransaction {
    return transaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  void deleteTransaction(String id){
    setState(() {
      transaction.removeWhere((tx) => tx.id==id);
    });
  }

  @override
  Widget build(BuildContext context) {
    void addTransaction(String title, double amount,DateTime selectedDate) {
      final tx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: selectedDate,
      );

      if (title.isEmpty || amount <= 0) {
        return;
      }
      setState(() {
        transaction.add(tx);
      });
      Navigator.of(context).pop();
    }

    void startAddTransaction(BuildContext ctx) {
      showModalBottomSheet(
          context: ctx,
          builder: (_) {
            return GestureDetector(
              onTap: () {},
              child: NewTransaction(addTransaction),
              // behavior: HitTestBehavior.opaque,
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Expenses"),
        actions: [
          IconButton(
            onPressed: () => startAddTransaction(context),
            icon: const Icon(Icons.add),
          ),
        ],
        foregroundColor: Colors.black,
      ),
      body: transaction.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nothing To Show'),
                  const Text('Please Enter Some data!!'),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/no-task.png',
                    height: 100,
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Chart(recentTransaction),
                TransactionList(transaction,deleteTransaction),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => startAddTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
