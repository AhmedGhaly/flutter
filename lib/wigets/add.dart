import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Add extends StatefulWidget {
  final Function addTX;
  Add(this.addTX);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final title = TextEditingController();
  final amount = TextEditingController();

  DateTime pickedDate;

  void pickTheDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      setState(() {
        pickedDate = datePicked;
      });
    });
  }

  void addTransaction() {
    final enteredAmount = double.parse(amount.text);
    final enteredTitle = title.text;
    if (enteredAmount <= 0 || enteredTitle.isEmpty) {
      return;
    }
    widget.addTX(
      enteredTitle,
      enteredAmount,
      pickedDate == null ? DateTime.now() : pickedDate,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'title',
                ),
                controller: title,
                onSubmitted: (_) => addTransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'amount'),
                keyboardType: TextInputType.number,
                controller: amount,
                onSubmitted: (_) => addTransaction(),
              ),
              Container(
                height: 100,
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        pickedDate == null
                            ? 'no date picked!!'
                            : 'picked date: ${DateFormat.yMd().format(pickedDate)}',
                        // style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        'choose date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: pickTheDate,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text(
                  'add transaction',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: addTransaction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
