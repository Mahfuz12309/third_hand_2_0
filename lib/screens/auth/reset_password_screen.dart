import 'package:flutter/material.dart';
import 'package:third_hand_2_0/components/large_heading_widget.dart';
import 'package:third_hand_2_0/constants/colors.dart';

import '../../form/reset_form.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String screenId = 'reset_password_screen';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              LargeHeadingWidget(
                heading: 'Forgot Password',
                subHeading: 'Enter yout email to continue your password reset',
                headingTextSize: 35,
                subheadingTextSize: 20,
              ),
              ResetForm(),
            ]),
      ),
    );
  }
}
