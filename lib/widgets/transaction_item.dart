import 'package:expenses_planner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Key key;
  final Function onDeleteIconPressed;
  final int index;
  TransactionItem({
    this.key,
    @required this.onDeleteIconPressed,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: Text('\$${transactions[index].amount.toStringAsFixed(2)}'),
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
                onPressed: onDeleteIconPressed,
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
                onPressed: onDeleteIconPressed,
              ),
      ),
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
