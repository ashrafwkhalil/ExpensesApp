import 'package:flutter/material.dart';
import './transactions.dart';
import 'package:intl/intl.dart';
import './transaction_tile.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  Function delete;
  TransactionList(this.transactions, this.delete);

  Widget buildWithoutTransactions() {
    return Container(
      child: Center(child: Text('No Stored Transactions')),
    );
  }

  Widget buildWithTransactions() {
    return ListView.builder(
        itemBuilder: (ctx, index) {
          return TransactionTile(
              transaction: transactions[index], delete: delete);
        },
        itemCount: transactions.length);
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? buildWithoutTransactions()
        :buildWithTransactions();
          
  }
}
