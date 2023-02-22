import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expences/Widgets/chart_bar.dart';
import 'package:my_expences/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> getTransaction;

  const Chart(this.getTransaction, {super.key});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (var i = 0; i < getTransaction.length; i++) {
        if (getTransaction[i].date.day == weekDay.day &&
            getTransaction[i].date.month == weekDay.month &&
            getTransaction[i].date.year == weekDay.year) {
          totalSum += getTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat('EEE').format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpendings {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 20, top: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: data['day'] as String,
                  spendingAmount: data['amount'] as double,
                  pctOfTotal: (data['amount'] as double) / totalSpendings),
            );
          }).toList(),
        ),
      ),
    );
  }
}
