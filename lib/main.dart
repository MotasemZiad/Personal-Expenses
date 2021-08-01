import 'dart:io' show Platform;
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './model/transaction.dart';
import './utils/constants.dart';
import './widgets/new_transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // ! to prevent the landscape mode in your app
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kColorPrimary,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(color: Colors.white),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _showChart = false;
  var _idRandom = Random().nextInt(1000000);

  void _addNewTransaction(String title, double amount, DateTime dateTime) {
    final transaction = Transaction(
      id: _idRandom.toString() + DateTime.now().toString(),
      title: title,
      amount: amount,
      date: dateTime,
    );
    setState(() {
      transactions.add(transaction);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(
          addNewTransaction: _addNewTransaction,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  List<Transaction> get recentTransactions {
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar) {
    return [
      SwitchListTile.adaptive(
        value: _showChart,
        onChanged: (value) {
          setState(() {
            _showChart = value;
          });
        },
        title: Text(
          'Show Chart',
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text('To view all the transactions this week'),
        activeColor: kColorPrimary,
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(recentTransactions: recentTransactions))
          : Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: TransactionList(deleteTransaction: _deleteTransaction))
    ];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery, AppBar appBar) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(recentTransactions: recentTransactions)),
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.7,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: TransactionList(deleteTransaction: _deleteTransaction)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: GestureDetector(
              onTap: () => _startAddNewTransaction(context),
              child: Icon(CupertinoIcons.add),
              behavior: HitTestBehavior.opaque,
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    print('move to transaction ModalBottomSheet!');
                    _startAddNewTransaction(context);
                  }),
            ],
          );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape) ..._buildLandscapeContent(mediaQuery, appBar),
            if (!isLandscape) ..._buildPortraitContent(mediaQuery, appBar),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      print('move to transaction ModalBottomSheet!');
                      _startAddNewTransaction(context);
                    },
                    tooltip: 'Add new Expense',
                    child: Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
          );
  }
}
