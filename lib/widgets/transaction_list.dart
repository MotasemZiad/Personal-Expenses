import 'package:expenses_planner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final Function deleteTransaction;
  TransactionList({@required this.deleteTransaction});

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

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: LayoutBuilder(
              builder: (context, constraints) => Column(
                children: [
                  Text(
                    'No Transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 22.0,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: kElevationShadow,
                margin: EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 8.0,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 32.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? TextButton.icon(
                          onPressed: () => showDeleteDialog(context, index),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          label: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () => showDeleteDialog(context, index),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}



/*!
Card(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: kMarginHorizontal,
                          vertical: kMarginVertical,
                        ),
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kColorPrimary,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: kColorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transactions[index].title.toString(),
                              style: Theme.of(context).textTheme.headline6,
                              overflow: TextOverflow.clip,
                              maxLines: 5,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(transactions[index].date),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );

 */ 