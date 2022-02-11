import 'package:flutter/material.dart';
import './transactions.dart';
import 'package:intl/intl.dart';
import './transaction_list.dart';
import './new_transaction.dart';

import './chart.dart';

class NewTransaction extends StatefulWidget {
  Function addt;
  NewTransaction(this.addt);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selectedDate;
  String titleEntered;
  String amountEntered;
  void editStuff() {
    setState(() {
      titleEntered = titleController.text;
      amountEntered = amountController.text;
    });
  }

  void submit() {
    var enteredTitle = titleController.text;
    var enteredAmount = amountController.text;
    if (enteredTitle.isEmpty || enteredAmount.isEmpty) return;

    widget.addt(
      double.parse(amountController.text),
      titleController.text,
      selectedDate == null ? DateTime.now() : selectedDate,
    );

    Navigator.of(context).pop();
  }

  void showDateChooser() {
    showDatePicker(
      context: context,
      lastDate: DateTime.now().add(
        Duration(days: 200),
      ),
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        Duration(days: 200),
      ),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 0,
          right: 0,
          left: 0,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [
           Container(
              decoration: BoxDecoration(color: Colors.green) ,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    
                    child: Container(
                      child: Text(
                        selectedDate == null
                            ? DateFormat.yMd().format(DateTime.now())
                            : DateFormat.yMd().format(selectedDate),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    onPressed: showDateChooser,
                  ),
                  Container(child: Text(titleController.text, style: TextStyle(fontSize: 18, color: Colors.white))),
                  Container(child: Text(amountController.text, style: TextStyle(fontSize: 18, color: Colors.white))),
                ],
              ),
            ),
          Card(
            
            child: Column(
              children: [
                TextField(
                  expands: false,
                  onChanged: (hello) => editStuff(),
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => submit(),
                ),
                TextField(
                  onChanged: (hello) => editStuff(),
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.green,
                  onSubmitted: (_) => submit(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: FlatButton(
                    child: Text('add', style: TextStyle(fontSize: 20)),
                    onPressed: submit,
                    textColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
