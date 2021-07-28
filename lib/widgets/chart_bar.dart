import 'package:expenses_planner/utils/constants.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPercentageOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Container(
              height: constraints.maxHeight * 0.12,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: constraints.maxWidth * 0.1,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: kColorPrimary,
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: 1 - spendingPercentageOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.12,
            child: FittedBox(child: Text(label)),
          ),
        ],
      ),
    );
  }
}
