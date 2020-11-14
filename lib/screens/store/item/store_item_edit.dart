import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:sell_or_swap/components/default_button.dart';
import 'package:sell_or_swap/components/loadin_modal.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/models/category.dart';
import 'package:sell_or_swap/models/item.dart';
import 'package:sell_or_swap/networking/rest_api.dart';
import 'package:sell_or_swap/bloc/token_auth.dart';
import 'package:sell_or_swap/repository/category_repository.dart';
import 'package:sell_or_swap/size_config.dart';
import 'components/pick_image_option.dart';
import 'components/store_item_form.dart';

class StoreItemEditScreen extends StatefulWidget {
  final Item item;

  const StoreItemEditScreen({Key key, this.item}) : super(key: key);
  @override
  _StoreItemEditScreenState createState() => _StoreItemEditScreenState();
}

class _StoreItemEditScreenState extends State<StoreItemEditScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File _image;
  final picker = ImagePicker();

  bool loading = false;

  // CategoryRepository
  CategoryRepository _repository;
  @override
  void initState() {
    _repository = CategoryRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Edit Item"),
      ),
      body: LoadingModal(
        loading: loading,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: FutureBuilder(
            future: _repository.getCategories(),
            builder: (context, snapshot) {
              if (snapshot.hasData) return buildEditForm(snapshot.data);
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
              return Center(
                child: LoadingBouncingGrid.circle(
                  borderColor: Colors.cyan,
                  backgroundColor: Colors.cyan,
                  size: 50.0,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Padding buildEditForm(List<ItemCategory> _categories) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getUiWidth(20), vertical: 15),
      child: Column(
        children: [
          FormBuilder(
            key: _formKey,
            initialValue: widget.item.toFormData(),
            child: StoreItemForm(
              categories: _categories,
            ),
          ),
          SizedBox(height: getUiHeight(10)),
          Container(
            height: getUiHeight(200),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: _image != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        _image,
                        fit: BoxFit.contain,
                      ),
                    )
                  : OutlineButton(
                      child: Text("Select Image"),
                      onPressed: selectIamge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
            ),
          ),
          SizedBox(height: getUiHeight(10)),
          DefaultButton(
            text: "Continue",
            press: () async {
              try {
                if (_formKey.currentState.saveAndValidate()) {
                  setState(() {
                    loading = true;
                  });
                  var _data = _formKey.currentState.value;
                  if (_image != null) {
                    String url = await RestApi().uploadImage(_image);
                    _data['image'] = url;
                  }
                  String storeId = Auth().currentUser.store.id.toString();
                  Map response = await RestApi()
                      .put("/store/$storeId/item/${widget.item.id}", _data);
                  if (response.containsKey('status') && response['status']) {
                    Get.snackbar(
                      'Success',
                      'Item updated successfully',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    setState(() {
                      loading = false;
                    });
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pop(context);
                  }
                }
              } catch (e) {
                setState(() {
                  loading = false;
                });
                Get.snackbar(
                  'Error!',
                  "$e",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.withOpacity(0.5),
                );
              }
            },
          )
        ],
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
