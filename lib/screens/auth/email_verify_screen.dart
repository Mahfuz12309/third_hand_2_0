import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:third_hand_2_0/components/custom_icon_button.dart';
import 'package:third_hand_2_0/constants/colors.dart';
import 'package:third_hand_2_0/constants/widgets.dart';
import 'package:third_hand_2_0/screens/location_screen.dart';
import 'package:third_hand_2_0/services/auth.dart';

class EmailVerifyScreen extends StatefulWidget {
  static const String screenId = 'email_otp_screen';
  const EmailVerifyScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  bool isPinEntered = false;
  String smsCode = "";

  Auth authService = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _body(context),
    );
  }

  Future<void> validateEmailOtp() async {
    if (kDebugMode) {
      print('sms code is : $smsCode');
    }
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verify Email',
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Check your email to verify your regsitered email',
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(children: [
            Image.asset(
              'assets/images/verify.png',
              width: double.infinity,
              height: 300,
            ),
            InkWell(
              onTap: () async {
                Navigator.pushReplacementNamed(
                    context, LocationScreen.screenId);
                var result = await OpenMailApp.openMailApp();
                if (!result.didOpen && !result.canOpen) {
                  customSnackBar(
                      context: context, content: 'No mail apps installed');
                } else if (!result.didOpen && result.canOpen) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return MailAppPickerDialog(
                        mailApps: result.options,
                      );
                    },
                  );
                }
              },
              child: CustomIconButton(
                  text: 'Verify Email',
                  bgColor: secondaryColor,
                  icon: Icons.verified_user,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
            )
          ]),
        ),
      ],
    );
  }
}
