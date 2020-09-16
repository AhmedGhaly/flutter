import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transactoin> _transactions;
  final Function deleteTrans;

  TransactionList(this._transactions, this.deleteTrans);
  void deleteTranaction(Transactoin tx) {
    deleteTrans(tx);
  }

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ?
        //  Column(
        //     children: [
        Center(
            child: Text(
              'ther is not transaction added yet!!',
              style: TextStyle(
                fontSize: 25,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        // SizedBox(
        //   height: 20,
        // ),
        // Image.asset(
        //   'assets/images/im.jpg',
        //   fit: BoxFit.cover,
        // ),
        // ],
        // )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                elevation: 15,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Container(
                      child: FittedBox(
                        child: Text(
                          '\$${_transactions[index].amount}',
                          // style: TextStyle(
                          //   fontSize: 20,
                          // ),
                        ),
                      ),
                      padding: EdgeInsets.all(8),
                    ),
                  ),
                  title: Text(
                    _transactions[index].title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(
                      _transactions[index].date,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () => deleteTranaction(_transactions[index]),
                  ),
                  // FlatButton.icon(
                  //   label: Text('nadia elhabla'),
                  //   textColor: Colors.red,
                  //   icon: Icon(
                  //     Icons.delete,
                  //     color: Colors.red,
                  //   ),
                  //   onPressed: () => deleteTranaction(_transactions[index]),
                  // ),
                ),
                /* 

                  */
                /*Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$' + _transactions[index].amount.toStringAsFixed(2),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _transactions[index].title,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy')
                                .format(_transactions[index].date),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  */
              );
            },
            itemCount: _transactions.length,
          );
  }
}
