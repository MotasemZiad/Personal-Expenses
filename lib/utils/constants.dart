import 'package:expenses_planner/model/transaction.dart';
import 'package:flutter/material.dart';

const kColorPrimary = Colors.purple;
const kCursorHeight = 22.0;
const kElevationShadow = 4.0;
const kMarginHorizontal = 16.0;
const kMarginVertical = 8.0;

final List<Transaction> transactions = [
  Transaction(
    id: 't1',
    title: 'New Shoes',
    amount: 60.38,
    date: DateTime.now(),
  ),
  Transaction(
    id: 't2',
    title: 'Weekly Groceries',
    amount: 120.38,
    date: DateTime.now(),
  ),
  Transaction(
    id: 't3',
    title: 'New Jacket',
    amount: 80.96,
    date: DateTime.now(),
  ),
  Transaction(
    id: 't4',
    title: 'New Computer',
    amount: 1260.79,
    date: DateTime.now(),
  ),
  Transaction(
    id: 't5',
    title: 'New Mobile',
    amount: 850.00,
    date: DateTime.now(),
  ),
  Transaction(
    id: 't6',
    title: 'Restaurant Meal',
    amount: 25.49,
    date: DateTime.now(),
  ),
];
