import 'package:flutter/material.dart';

import './wigets/statics.dart';
import './wigets/add.dart';
import './models/transaction.dart';
import './wigets/transactoinList.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter app',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purple[200],
        fontFamily: 'Quicksand',
        textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 30,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headline2: TextStyle(
              fontSize: 23,
            )),
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transactoin> _transactions = [
    Transactoin(
      id: '1',
      amount: 2.99,
      title: 'choose',
      date: DateTime.now(),
    ),
    Transactoin(
      id: '2',
      amount: 3.99,
      title: 'cheese',
      date: DateTime.now(),
    ),
    Transactoin(
      id: '3',
      amount: 8.99,
      title: 'cofee',
      date: DateTime.now(),
    ),
  ];

  void addTx(String title, double amount, DateTime date) {
    final tx = Transactoin(
      id: DateTime.now().toString(),
      amount: amount,
      title: title,
      date: date,
    );
    setState(() {
      _transactions.add(tx);
    });
  }

  void deleteTx(Transactoin transaction) {
    setState(() {
      _transactions.remove(transaction);
    });
  }

  void startNewTransaction(BuildContext cxt) {
    showModalBottomSheet(
      context: cxt,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Add(addTx),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Transactoin> get recentTransaction {
    // List<Transactoin> temp = [];
    // for (int i = 0; i < _transactions.length; i++) {
    //   if (_transactions[i]
    //       .date
    //       .isAfter(DateTime.now().subtract(Duration(days: 7)))) {
    //     temp.add(_transactions[i]);
    //   }
    // }
    // return temp;
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _showChart = true;

  @override
  Widget build(BuildContext context) {
    final landScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('my app'),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => startNewTransaction(context),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: [
          if (landScape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('show the chart'),
                Switch(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                )
              ],
            ),
          if (landScape)
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        .8,
                    child: Statics(recentTransaction),
                  )
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        .9,
                    child: TransactionList(_transactions, deleteTx),
                  ),
          if (!landScape)
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  .4,
              child: Statics(recentTransaction),
            ),
          if (!landScape)
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  .6,
              child: TransactionList(_transactions, deleteTx),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => startNewTransaction(context),
      ),
    );
  }
}

// Flexible wiget
