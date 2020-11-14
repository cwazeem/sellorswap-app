import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sell_or_swap/models/category.dart';
import 'package:sell_or_swap/size_config.dart';

class StoreItemForm extends StatelessWidget {
  final List<ItemCategory> categories;

  const StoreItemForm({Key key, this.categories}) : super(key: key);
  Widget build(BuildContext context) {
    return Column(
      children: [
        categories == null || categories.length == 0
            ? Container()
            : FormBuilderDropdown(
                attribute: 'category_id',
                valueTransformer: (value) => value.toString(),
                items: categories
                    .map((e) => DropdownMenuItem(
                          child: Text(e.name),
                          value: e.id.toString(),
                        ))
                    .toList(),
              ),
        SizedBox(height: getUiHeight(20)),
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
          valueTransformer: (value) => value.toString(),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.min(1),
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
