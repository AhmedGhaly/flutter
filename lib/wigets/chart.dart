import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final String lable;
  final double totalAmount;
  final double amount;

  Chart(this.lable, this.amount, this.totalAmount);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(
                child: Text('\$${amount.toStringAsFixed(0).toString()}'),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * .05,
            ),
            Container(
              height: constraints.maxHeight * .6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: amount == 0 ? 0.0 : (amount / totalAmount),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * .05,
            ),
            Container(
              child: Text(lable),
              height: constraints.maxHeight * .15,
            ),
          ],
        );
      },
    );
  }
}
