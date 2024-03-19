import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicknoms/constant/constant.dart';
import 'package:quicknoms/controller/provider/authProvider/authProvider.dart';

class MobileAuthServices {
  static bool checkAuthentication() {
    User? user = auth.currentUser;
    if (user == null) {
      return false;
    }
    return true;
  }

  static recieveOTP(
      {required BuildContext context, required String mobileNo}) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: mobileNo,
          verificationCompleted: (PhoneAuthCredential credentials) {},
          verificationFailed: (FirebaseAuthException exception) {},
          codeSent: (String verificationID, int? resendToken) {},
          codeAutoRetrievalTimeout: (String verificationID) {});
    } catch (e) {}
  }

  static verifyOTP({required BuildContext, required String otp}) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: context.read<MobileAuthProvider>().verificationID!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
    } catch (e) {}
  }
}
