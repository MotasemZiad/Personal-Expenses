import 'package:expenses_planner/utils/constants.dart';
import 'package:expenses_planner/widgets/empty_transactions.dart';
import 'package:expenses_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final Function deleteTransaction;
  TransactionList({@required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: EmptyTransactions(),
          )
        : ListView.builder(
            itemBuilder: (context, index) => TransactionItem(
                onDeleteIconPressed: () => showDeleteDialog(context, index),
                index: index),
            itemCount: transactions.length,
          );
  }

  void showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Transaction!!'),
        content: Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(
            onPressed: () {
              deleteTransaction(transactions[index].id);
              Navigator.pop(context);
            },
            child: Text(
              'Yes',
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
              )),
        ],
        titleTextStyle: TextStyle(
          color: Colors.red.shade600,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
