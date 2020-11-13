import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sell_or_swap/size_config.dart';

class StoreItemForm extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderTextField(
          attribute: 'name',
          decoration: InputDecoration(
            labelText: "Item name",
            hintText: "Enter name of item",
          ),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(3),
          ],
        ),
        SizedBox(height: getUiHeight(20)),
        FormBuilderTextField(
          attribute: 'condition',
          decoration: InputDecoration(
            labelText: "Condition",
            hintText: "Enter condition",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validators: [
            FormBuilderValidators.required(),
          ],
        ),
        SizedBox(height: getUiHeight(20)),
        FormBuilderTextField(
          attribute: 'price',
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Price",
            hintText: "Enter your price",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.min(1),
          ],
        ),
        SizedBox(height: getUiHeight(20)),
        FormBuilderTextField(
          attribute: 'contact',
          decoration: InputDecoration(
            labelText: "Contact",
            hintText: "Enter your contact",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(10),
          ],
        ),
        SizedBox(height: getUiHeight(20)),
        FormBuilderTextField(
          attribute: 'description',
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: "Description",
            hintText: "Enter your description",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(5),
          ],
        ),
        SizedBox(height: getUiHeight(15)),
      ],
    );
  }
}
