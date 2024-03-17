import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicknoms/utils/textStyles.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Account Screen',
          style: AppTextStyles.body14,
        ),
      ),
    );
  }
}