import 'package:flutter/material.dart';
import './transactions.dart';
import 'package:intl/intl.dart';
import './transaction_list.dart';
import './new_transaction.dart';

import './chart.dart';

class ChartBar extends StatelessWidget {
  double amount;
  String day;
  double weekTotal;
  double get fraction {
    if (weekTotal == 0) {
      return 0;
    }
    return (amount / weekTotal);
  }

  ChartBar(this.amount, this.day, this.weekTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight *0.18,
            child: FittedBox(
              child: Text('\$${amount.toStringAsFixed(0)}'),
            ),
          ),
          Container(
            height: constraints.maxHeight*0.64,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: fraction,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: constraints.maxHeight*0.18,
            child: FittedBox(child: Text(day))),
        ],
      );
    });
  }
}
