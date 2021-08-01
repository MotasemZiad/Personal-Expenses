import 'package:expenses_planner/utils/constants.dart';
import 'package:expenses_planner/widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({this.addNewTransaction});

  @override
  _NewTransactionState createState() {
    print('createState method has implemented');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData(BuildContext context) {
    if (_validateInputs()) {
      if (_validateAmount()) {
        widget.addNewTransaction(
          _titleController.text,
          double.parse(_amountController.text),
          _selectedDate,
        );
        print(
            'You\'ve just add a transaction. Title: ${_titleController.text}, Amount: ${_amountController.text}');
        _titleController.clear();
        _amountController.clear();
        Navigator.of(context).pop();
        showSnackBar(context, 'Transaction added successfully!', Colors.green);
      } else {
        showSnackBar(
            context, 'Please enter a valid (positive) amount', Colors.red);
      }
    } else {
      showSnackBar(context, 'Please Fill Fields', Colors.red);
    }
  }

  bool _validateInputs() {
    return _titleController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        _selectedDate != null;
  }

  bool _validateAmount() {
    final enteredAmount = double.parse(_amountController.text);
    return enteredAmount > 0;
  }

  void showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: Duration(milliseconds: 3000),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      _selectedDate = value;
      setState(() {
        print('setState method has implemented');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    print('initState method has implemented');
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget method has implemented');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose method has implemented');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _titleController,
                  cursorHeight: kCursorHeight,
                  keyboardType: TextInputType.name,
                  onEditingComplete: () {
                    _submitData(context);
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: _amountController,
                  cursorHeight: kCursorHeight,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onEditingComplete: () {
                    _submitData(context);
                  },
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                ),
                SizedBox(height: 6.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No dates chosen!'
                            : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveButton(
                      onPressed: _presentDatePicker,
                      label: 'Choose Date',
                      fontWeight: FontWeight.bold,
                      isTextButton: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                AdaptiveButton(
                  onPressed: () => _submitData(context),
                  label: 'Add Transaction',
                  backgroundColor: kColorPrimary,
                  buttonStyle: ElevatedButton.styleFrom(
                      onPrimary: Theme.of(context).textTheme.button.color),
                  fontSize: 16.0,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
