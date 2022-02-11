import 'package:expensesapp/slider_amount.dart';
import 'package:flutter/material.dart';
import './transactions.dart';
import 'package:intl/intl.dart';
import './transaction_list.dart';
import './new_transaction.dart';

import './chart.dart';



class TransactionTile extends StatelessWidget {
  const TransactionTile({
    Key key,
    @required this.transaction,
    @required this.delete,
  }) : super(key: key);

  final Transaction transaction;
  final Function delete;


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: Center(
          child: Text("g o o d  b y e",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              )),
        ),
        decoration: BoxDecoration(
          color: Colors.black,
        ),
      ),
      onDismissed: (_) {
        delete(transaction.id);
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
        child: Row(children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 3,
            ),
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.green,
              width: 2,
            )),
            child: Text(
              '\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.title,
                    style: Theme.of(context).textTheme.headline6),
                Text(
                  DateFormat.yMMMd()
                      .format(transaction.date),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
