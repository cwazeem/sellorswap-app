import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sell_or_swap/size_config.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderTextField(
          attribute: 'name',
          decoration: InputDecoration(
            labelText: "Name",
            hintText: "Enter your name",
          ),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(3),
          ],
        ),
        SizedBox(height: getUiHeight(20)),
        FormBuilderTextField(
          attribute: 'email',
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
          ),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ],
        ),
        SizedBox(height: getUiHeight(20)),
        FormBuilderPhoneField(
          attribute: 'mobile',
          initialValue: 'GH',
          countryFilterByIsoCode: [
            "DZ",
            "AO",
            "BJ",
            "BW",
            "BF",
            "BI",
            "GH",
            "PK"
          ],
          decoration: InputDecoration(
            labelText: "Phone",
            hintText: "Enter your phone",
          ),
          validators: [
            FormBuilderValidators.required(),
          ],
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: getUiHeight(20)),
        FormBuilderTextField(
          attribute: 'password',
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
          ),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(6),
          ],
          obscureText: true,
        ),
        SizedBox(height: getUiHeight(20)),
        FormBuilderTextField(
          attribute: 'confirm_password',
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter your password again",
          ),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(6),
          ],
          obscureText: true,
        ),
      ],
    );
  }
}
