import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quicknoms/utils/colors.dart';
import 'package:quicknoms/utils/textStyles.dart';
import 'package:sizer/sizer.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  int resendOTPCounter = 60;

  decreaseOTPCounter() async {
    if (resendOTPCounter > 0) {
      setState(() {
        resendOTPCounter -= 1;
      });
      await Future.delayed(const Duration(seconds: 1), () {
        decreaseOTPCounter();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        decreaseOTPCounter();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            left: 5.w,
            bottom: 3.h,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(2.h),
                    backgroundColor: white,
                    elevation: 2),
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  size: 3.h,
                  color: Colors.black87,
                )),
          ),
          Positioned(
              right: 0.w,
              bottom: 3.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(2.h),
                    backgroundColor: white,
                    elevation: 2),
                child: Row(children: [
                  Text(
                    'Next  ',
                    style: AppTextStyles.body14,
                  ),
                  FaIcon(
                    FontAwesomeIcons.arrowRight,
                    size: 3.h,
                    color: Colors.black87,
                  ),
                ]),
              )),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Enter the 4-digit code sent to you at 05599224612',
            style: AppTextStyles.body16,
          ),
          SizedBox(
            height: 3.h,
          ),
          PinCodeTextField(
            appContext: context,
            length: 4,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(2),
              fieldHeight: 18.w,
              fieldWidth: 15.w,
              activeFillColor: Colors.white,
              inactiveColor: greyShade3,
              inactiveFillColor: greyShade3,
              selectedFillColor: white,
              selectedColor: black,
              activeColor: black,
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: transparent,
            enableActiveFill: true,
            errorAnimationController: errorController,
            controller: otpController,
            onCompleted: (v) {},
            onChanged: (value) {},
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.sp),
                  color: greyShade3,
                ),
                child: Text(
                  'I haven\'t recieved the code (0.${resendOTPCounter})',
                  style: AppTextStyles.small10
                      .copyWith(color: resendOTPCounter <= 0 ? black : grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
