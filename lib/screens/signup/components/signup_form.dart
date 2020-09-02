import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/size_config.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _retypePasswordTextController = TextEditingController();

  String initialCountry = 'GH';
  PhoneNumber _number = PhoneNumber(isoCode: 'GH');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _nameTextController,
          decoration: InputDecoration(
            labelText: "Name",
            hintText: "Enter your name",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: (String value) {
            if (value.isEmpty) return "Please enter name";
            return null;
          },
        ),
        SizedBox(height: getUiHeight(20)),
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
        SizedBox(height: getUiHeight(20)),
        InternationalPhoneNumberInput(
          countries: ["DZ", "AO", "BJ", "BW", "BF", "BI", "GH"],
          inputDecoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Mobile",
            hintText: "Please enter mobile",
          ),
          formatInput: false,
          ignoreBlank: false,
          textFieldController: _phoneTextController,
          onInputChanged: (PhoneNumber number) {
            setState(() {
              _number = number;
            });
          },
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          autoValidate: false,
          onInputValidated: (bool value) {
            print(value);
          },
        ),
        SizedBox(height: getUiHeight(20)),
        // TextFormField(
        //   controller: _phoneTextController,
        //   decoration: InputDecoration(
        //     labelText: "Mobile",
        //     hintText: "Enter your Mobile",
        //     floatingLabelBehavior: FloatingLabelBehavior.always,
        //   ),
        //   validator: (String value) {
        //     if (value.isEmpty)
        //       return "Please enter mobile";
        //     else if (!mobileValidatorRegExp.hasMatch(value))
        //       return "Please enter valid mobile";
        //     return null;
        //   },
        // ),
        // SizedBox(height: getUiHeight(20)),
        TextFormField(
          controller: _passwordTextController,
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
        SizedBox(height: getUiHeight(20)),
        TextFormField(
          controller: _retypePasswordTextController,
          decoration: InputDecoration(
            labelText: "Retype Password",
            hintText: "Enter your password again",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: (String value) {
            if (value.isEmpty)
              return kPassNullError;
            else if (value.length < 6)
              return kShortPassError;
            else if (value != _passwordTextController.text)
              return kMatchPassError;
            return null;
          },
        ),
        SizedBox(height: getUiHeight(15)),
      ],
    );
  }
}
