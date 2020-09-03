import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/size_config.dart';

class SellItemForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SellItemForm> {
  final _itemNameTextController = TextEditingController();
  final _itemStatusTextController = TextEditingController();
  final _itemPriceTextController = TextEditingController();
  final _contactTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();

  String initialCountry = 'GH';
  PhoneNumber _number = PhoneNumber(isoCode: 'GH');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _itemNameTextController,
          decoration: InputDecoration(
            labelText: "Item name",
            hintText: "Enter name of item",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: (String value) {
            if (value.isEmpty) return "Please enter name";
            return null;
          },
        ),
        SizedBox(height: getUiHeight(20)),
        TextFormField(
          controller: _itemStatusTextController,
          decoration: InputDecoration(
            labelText: "Status",
            hintText: "Enter satatus",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: (String value) {
            if (value.isEmpty) return 'Please enter status';
            return null;
          },
        ),
        SizedBox(height: getUiHeight(20)),
        TextFormField(
          controller: _itemPriceTextController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Price",
            hintText: "Enter your price",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: (String value) {
            if (value.isEmpty) return "Please enter price";
            return null;
          },
        ),
        SizedBox(height: getUiHeight(20)),
        TextFormField(
          controller: _contactTextController,
          decoration: InputDecoration(
            labelText: "Contact",
            hintText: "Enter your contact",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: (String value) {
            if (value.isEmpty)
              return "Please enter contact";
            else if (value.length < 11) return 'Please enter valid contact #';
            return null;
          },
        ),
        SizedBox(height: getUiHeight(20)),
        TextFormField(
          controller: _descriptionTextController,
          decoration: InputDecoration(
            labelText: "Description",
            hintText: "Enter your description",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: (String value) {
            if (value.isEmpty)
              return 'Pelease enter description';
            else if (value.length < 6)
              return 'please enter at least 10 character';
            return null;
          },
        ),
        SizedBox(height: getUiHeight(15)),
      ],
    );
  }
}
