import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quicknoms/utils/colors.dart';
import 'package:quicknoms/utils/textStyles.dart';
import 'package:sizer/sizer.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  String selectedCountry = '+91';
  TextEditingController mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            SizedBox(
              height: 3.h,
            ),
            Text(
              'Enter your mobile number',
              style: AppTextStyles.body16,
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode:
                          true, // optional. Shows phone code before the country name.
                      onSelect: (Country country) {
                        setState(() {
                          selectedCountry = '+${country.phoneCode}';
                        });
                        print('Select country: ${country.displayName}');
                      },
                    );
                  },
                  child: Container(
                    height: 6.h,
                    width: 25.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                        color: greyShade3),
                    child: Text(
                      selectedCountry,
                      style: AppTextStyles.body14,
                    ),
                  ),
                ),
                SizedBox(
                  width: 70.w,
                  child: TextField(
                    controller: mobileController,
                    cursorColor: black,
                    style: AppTextStyles.textFieldHintTextStyle,
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: black,
                    minimumSize: Size(90.w, 6.h),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero))),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text('Next',
                          style: AppTextStyles.body16.copyWith(color: white)),
                    ),
                    Positioned(
                      right: 2.w,
                      child: Icon(
                        Icons.arrow_forward,
                        color: white,
                        size: 4.h,
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 3.h,
            ),
            Text(
              'By proceeding, you concent to get calls, Whatsapp or SMS messages, including by automated means, from QuickNoms to the number provided.',
              style: AppTextStyles.small12.copyWith(
                color: grey,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Divider(
                  color: grey,
                )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    'or',
                    style: AppTextStyles.small12.copyWith(color: grey),
                  ),
                ),
                Expanded(
                    child: Divider(
                  color: grey,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
