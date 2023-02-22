import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addnewtransaction;

  const NewTransaction(this.addnewtransaction, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  String inputTitle = '';

  TextEditingController inputTitleController = TextEditingController();
  TextEditingController inputAmountController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  double inputAmount = 0;

  void presentDateTimePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title:'),
            controller: inputTitleController,
            onChanged: (val) {
              inputTitle = val;
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount:'),
            controller: inputAmountController,
            keyboardType: TextInputType.number,
            onChanged: (val) {
              inputAmount = double.parse(val);
            },
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                      'Choosen Date : ${DateFormat.yMMMd().format(selectedDate)}')),
              TextButton(
                onPressed: presentDateTimePicker,
                child: const Text('Choose Date'),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {
              widget.addnewtransaction(inputTitle, inputAmount, selectedDate);
              inputTitleController.clear();
              inputAmountController.clear();
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
