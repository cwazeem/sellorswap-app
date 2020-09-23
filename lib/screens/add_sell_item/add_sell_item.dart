import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sell_or_swap/components/default_button.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/models/category.dart';
import 'package:sell_or_swap/screens/add_sell_item/components/pick_image_option.dart';
import 'package:sell_or_swap/screens/add_sell_item/components/sell_item_form.dart';
import 'package:sell_or_swap/size_config.dart';

class AddSellItem extends StatefulWidget {
  final AppCategory category;

  const AddSellItem({Key key, this.category}) : super(key: key);
  @override
  _AddSellItemState createState() => _AddSellItemState();
}

class _AddSellItemState extends State<AddSellItem> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getUiWidth(20)),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: getUiHeight(20)),
            Center(
              child: Text(
                "${widget.category.name}",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getUiWidth(28),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                "You are inserted item in the this category",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: getUiHeight(20)),
            Form(
              key: _formKey,
              child: SellItemForm(),
            ),
            SizedBox(height: getUiHeight(20)),
            Container(
              height: getUiHeight(200),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: _image != null
                    ? Image.file(_image)
                    : OutlineButton(
                        child: Text("Select Image"),
                        onPressed: selectIamge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
              ),
            ),
            SizedBox(height: getUiHeight(20)),
            DefaultButton(
              text: "Continue",
              press: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text("Success!"),
                        children: [
                          Container(
                            child: Center(
                              child: Text("Successfully Added"),
                            ),
                          )
                        ],
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  selectIamge() async {
    _scaffoldKey.currentState.showBottomSheet(
      (context) => PickImageOption(
        onCameraTap: () async {
          try {
            final pickedFile =
                await picker.getImage(source: ImageSource.camera);
            if (pickedFile != null) {
              setState(() {
                _image = File(pickedFile.path);
              });
              Navigator.pop(context);
            }
          } catch (e) {
            _scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text("$e")));
          }
        },
        onGallaryTap: () async {
          try {
            final pickedFile =
                await picker.getImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              setState(() {
                _image = File(pickedFile.path);
              });
              Navigator.pop(context);
            }
          } catch (e) {
            _scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text("$e")));
          }
        },
      ),
    );
  }
}
