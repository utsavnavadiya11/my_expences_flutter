import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expences/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(this.transactions, this.deleteTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey.withAlpha(20),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          reverse: false,
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: ListTile(
                leading: CircleAvatar(
                  child: FittedBox(
                      child:
                          Text(transactions[index].amount.toStringAsFixed(0))),
                ),
                title: Text(transactions[index].title),
                subtitle:
                    Text(DateFormat.yMMMd().format(transactions[index].date)),
                trailing: IconButton(
                  onPressed: () => deleteTransaction(transactions[index].id),
                  icon: const Icon(Icons.delete),
                ),
              ),
            );
          },
          itemCount: transactions.length,
        ),
      ),
    );
  }
}
