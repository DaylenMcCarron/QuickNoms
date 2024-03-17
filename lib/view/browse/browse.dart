import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicknoms/utils/textStyles.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Browse Screen',
          style: AppTextStyles.body14,
        ),
      ),
    );
  }
}
