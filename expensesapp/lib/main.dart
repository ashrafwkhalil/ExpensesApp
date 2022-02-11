import 'package:expensesapp/slider_amount.dart';
import 'package:flutter/material.dart';
import './transactions.dart';
import 'package:intl/intl.dart';
import './transaction_list.dart';
import './new_transaction.dart';

import './chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'QuickSand',
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  ),
                )),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SingleChildScrollView(
                  child: GestureDetector(
            child: NewTransaction(addTransaction),
            onTap: () {},
          ),
        );
      },
    );
  }

  double amountQuick = 0;
  double titleChoice = 0;

  List<String> spendOptions = ['food', 'fun', 'shopping', 'groceries', 'bill'];

  final List<Transaction> transactions = [];
  List<Transaction> get recentTransactions {
    return transactions.where((t) {
      return t.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addTransaction(double amountx, String titlex, DateTime datex) {
    Transaction t = Transaction(
      amount: amountx,
      title: titlex,
      date: datex,
      id: DateTime.now().toString(),
    );
    setState(() {
      transactions.add(t);
    });
  }

  void deleteTransactions(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  heightNoAppBar(var context, AppBar appBar) {
    return MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top;
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text('Expense Tracker'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.green,
          ),
          onPressed: () => startAddNewTransaction(context),
        ),
      ],
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            ),
            Container(
              height: heightNoAppBar(context, appBar) * 0.07,
              child: RaisedButton(
                child: Text('add custom transaction',
                    style: TextStyle(fontSize: 20)),
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  startAddNewTransaction(context);
                },
              ),
            ),
            Container(
                height: heightNoAppBar(context, appBar) * 0.16,
                child: Chart(recentTransactions)),
            Container(
                height: heightNoAppBar(context, appBar) * 0.56,
                child: TransactionList(transactions, deleteTransactions)),
            Container(
              height: heightNoAppBar(context, appBar) * 0.07,
              width: double.infinity,
              child: Slider(
                inactiveColor: Colors.white,
                activeColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    titleChoice = value;
                  });
                },
                value: titleChoice,
                min: 0,
                max: 4,
                divisions: 4,
              ),
            ),
            Container(
              height: heightNoAppBar(context, appBar) * 0.07,
              width: double.infinity,
              child: Slider(
                inactiveColor: Colors.white,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    amountQuick = value;
                  });
                },
                value: amountQuick,
                min: 0,
                max: 40,
              ),
            ),
            Container(
              height: heightNoAppBar(context, appBar) * 0.07,
              child: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text(
                    spendOptions[titleChoice.toInt()] +
                        '      ' +
                        amountQuick.toStringAsFixed(2),
                    style: TextStyle(fontSize: 25)),
                onPressed: () {
                  addTransaction(amountQuick, spendOptions[titleChoice.toInt()],
                      DateTime.now());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
