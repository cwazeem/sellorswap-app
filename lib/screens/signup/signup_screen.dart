import 'package:flutter/material.dart';
import 'package:sell_or_swap/components/default_button.dart';
import 'package:sell_or_swap/components/have_account_text.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/size_config.dart';
import 'components/signup_form.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Ui Variables
  final _formKey = GlobalKey<FormState>();

  bool _formAutoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getUiWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text(
                    "Let get you started",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getUiWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign up with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getUiHeight(20)),
                  Form(
                    key: _formKey,
                    autovalidate: _formAutoValidate,
                    child: SignupForm(),
                  ),
                  SizedBox(height: getUiHeight(20)),
                  DefaultButton(
                    text: "Register",
                    press: () {
                      if (_formKey.currentState.validate()) {
                      } else {
                        setState(() {
                          _formAutoValidate = true;
                        });
                      }
                    },
                  ),
                  SizedBox(height: getUiHeight(20)),
                  HaveAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
