import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart.dart';
import '../models/transaction.dart';

class Statics extends StatelessWidget {
  final List<Transactoin> transactoin;
  Statics(this.transactoin);

//// get anther way to do that
  List<Map<String, Object>> get groupTranactoin {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double dayAmount = 0.0;
      for (int i = 0; i < transactoin.length; i++) {
        if (transactoin[i].date.day == weekDay.day &&
            transactoin[i].date.month == weekDay.month &&
            transactoin[i].date.year == weekDay.year) {
          dayAmount += transactoin[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': dayAmount};
    }).reversed.toList();
  }

  double get totalSum {
    return groupTranactoin.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupTranactoin.map((tx) {
              return Flexible(
                fit: FlexFit.tight,
                child: Chart(
                  tx['day'],
                  tx['amount'],
                  totalSum,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
