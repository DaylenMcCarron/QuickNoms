import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInLogicScreen extends StatefulWidget {
  const SignInLogicScreen({super.key});

  @override
  State<SignInLogicScreen> createState() => _SignInLogicScreenState();
}

class _SignInLogicScreenState extends State<SignInLogicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image(
        image: AssetImage(
          'assets/Images/splashScreenImage/SplashScreen.png',
        ),
      ),
    );
  }
}
