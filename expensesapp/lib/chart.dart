import 'package:flutter/material.dart';
import './transactions.dart';
import 'package:intl/intl.dart';
import './transaction_list.dart';
import './new_transaction.dart';

import './chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get dayAmountPairs {
    return List.generate(7, (index) {
      var day = DateTime.now().subtract(Duration(days: index));
      double amount = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == day.day &&
            recentTransactions[i].date.month == day.month) {
          amount += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(day).substring(0, 1),
        'amount': amount
      };
    }).reversed.toList();
  }

  double get weeklyTotal {
    double x = 0;
    for (var i = 0; i < recentTransactions.length; i++) {
      x += recentTransactions[i].amount;
    }
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: dayAmountPairs.map((da) {
        return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(da['amount'], da['day'], weeklyTotal));
      }).toList(),
    ));
  }
}
