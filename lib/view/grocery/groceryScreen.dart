import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicknoms/utils/textStyles.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Grocery Screen',
          style: AppTextStyles.body14,
        ),
      ),
    );
  }
}
