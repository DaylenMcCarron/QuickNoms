import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicknoms/constant/constant.dart';
import 'package:quicknoms/controller/provider/authProvider/authProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quicknoms/view/authScreens/mobileLoginScreen.dart';
import 'package:quicknoms/view/authScreens/otpScreen.dart';
import 'package:quicknoms/view/bottomNavigationBar/bottomNavigationBar.dart';
import 'package:quicknoms/view/signInLogicScreen/signInLogicScreen.dart';
import 'package:quicknoms/view/userRegistrationScreen/userRegistrationScreen.dart';

class MobileAuthServices {
  static bool checkAuthentication(BuildContext context) {
    User? user = auth.currentUser;
    if (user == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MobileLoginScreen()),
          (route) => false);
      return false;
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const BottomNavigationBarQuickNoms()),
        (route) => false);
    return true;
  }

  static recieveOTP(
      {required BuildContext context, required String mobileNo}) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: mobileNo,
          verificationCompleted: (PhoneAuthCredential credentials) {
            log(credentials as String);
          },
          verificationFailed: (FirebaseAuthException exception) {
            log(exception.toString());
            throw Exception(exception);
          },
          codeSent: (String verificationID, int? resendToken) {
            context
                .read<MobileAuthProvider>()
                .updateVerificationID(verificationID);
            Navigator.push(
                context,
                PageTransition(
                    child: const OTPScreen(),
                    type: PageTransitionType.rightToLeft));
          },
          codeAutoRetrievalTimeout: (String verificationID) {});
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static verifyOTP({required BuildContext context, required String otp}) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: context.read<MobileAuthProvider>().verificationID!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      Navigator.push(
          context,
          PageTransition(
              child: const SignInLogicScreen(),
              type: PageTransitionType.rightToLeft));
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static checkUserRegistration({required BuildContext context}) async {
    bool userIsRegistered = false;
    try {
      await firestore
          .collection('User')
          .where('userID', isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        value.size > 0 ? userIsRegistered = true : userIsRegistered = false;
        log('User is Registered = $userIsRegistered');
        if (userIsRegistered) {
          //PushNotificationServices.initializeFCM();
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const BottomNavigationBarQuickNoms(),
                type: PageTransitionType.rightToLeft),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const UserRegistraionScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false,
          );
        }
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
