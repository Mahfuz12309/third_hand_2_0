import 'package:flutter/material.dart';
import 'package:third_hand_2_0/components/large_heading_widget.dart';
import 'package:third_hand_2_0/constants/colors.dart';
import 'package:third_hand_2_0/form/login_form.dart';

class LoginScreen extends StatefulWidget {
  static const String screenId = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        LargeHeadingWidget(
            heading: 'Welcome', subHeading: 'Sign In to Continue'),
        LogInForm(),
      ]),
    );
  }
}
