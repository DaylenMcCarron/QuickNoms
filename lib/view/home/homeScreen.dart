import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicknoms/utils/textStyles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home Screen',
          style: AppTextStyles.body14,
        ),
      ),
    );
  }
}