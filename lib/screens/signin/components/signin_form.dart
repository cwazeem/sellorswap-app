import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_or_swap/bloc/token_auth.dart';
import 'package:sell_or_swap/components/default_button.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/size_config.dart';
import 'package:sell_or_swap/repository/user_repository.dart';

class SignInForm extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SignInForm({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _remember = false;

  bool _autoValidate = false;
  // Database API Objects
  UserRepository _userRepository;
  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTextController,
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: (String value) {
              if (value.isEmpty)
                return kEmailNullError;
              else if (!emailValidatorRegExp.hasMatch(value))
                return kInvalidEmailError;
              return null;
            },
          ),
          SizedBox(height: getUiHeight(15)),
          TextFormField(
            controller: _passwordTextController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: (String value) {
              if (value.isEmpty)
                return kPassNullError;
              else if (value.length < 6) return kShortPassError;
              return null;
            },
          ),
          SizedBox(height: getUiHeight(10)),
          Row(
            children: [
              Checkbox(
                value: _remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    _remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'forget'),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(height: getUiHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                try {
                  await Auth().login(
                      _emailTextController.text, _passwordTextController.text);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                } catch (e) {
                  Get.snackbar(
                    "Error!",
                    "$e",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red.withOpacity(0.3),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
