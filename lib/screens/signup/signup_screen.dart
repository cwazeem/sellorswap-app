import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sell_or_swap/bloc/token_auth.dart';
import 'package:sell_or_swap/components/default_button.dart';
import 'package:sell_or_swap/components/have_account_text.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/size_config.dart';
import 'components/signup_form.dart';
import 'package:sell_or_swap/components/loadin_modal.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Ui Variables
  final _fbKey = GlobalKey<FormBuilderState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingModal(
        loading: loading,
        child: SafeArea(
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
                    FormBuilder(
                      key: _fbKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: SignupForm(),
                    ),
                    SizedBox(height: getUiHeight(20)),
                    DefaultButton(
                      text: "Register",
                      press: () async {
                        try {
                          if (_fbKey.currentState.saveAndValidate()) {
                            print(_fbKey.currentState.value);
                            var data = _fbKey.currentState.value;
                            await Auth().register(data, context);
                          }
                        } catch (e) {}
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
      ),
    );
  }
}
