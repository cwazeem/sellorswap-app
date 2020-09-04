import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_or_swap/components/default_button.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/providers/auth_provider.dart';
import 'package:sell_or_swap/size_config.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
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
                _formKey.currentState.save();
                _emailTextController.text = "";
                _passwordTextController.text = "";
                Provider.of<AuthProvider>(context, listen: false)
                    .doLogin(context, widget.scaffoldKey,
                        _emailTextController.text, _passwordTextController.text)
                    .then(
                      (value) {},
                    );
              } else {
                setState(() {
                  _autoValidate = true;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
