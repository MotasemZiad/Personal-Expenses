import 'package:expenses_planner/utils/constants.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPercentageOfTotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
          SizedBox(
            height: 4.0,
          ),
          Container(
            height: 80,
            width: 10,
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
            height: 4.0,
          ),
          Text(label),
        ],
      ),
    );
  }
}
