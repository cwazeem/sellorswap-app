import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sell_or_swap/components/default_button.dart';
import 'package:sell_or_swap/models/address_from_geocode.dart';
import 'package:sell_or_swap/networking/rest_api.dart';
import 'package:sell_or_swap/size_config.dart';
import 'package:sell_or_swap/bloc/token_auth.dart';

class CreateStoreScreen extends StatelessWidget {
  CreateStoreScreen({Key key, this.pickedAddress}) : super(key: key);

  final AddressFromGeoCode pickedAddress;
  final _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Store"),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _fbKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
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
                SizedBox(height: getUiHeight(10)),
                FormBuilderTextField(
                  attribute: 'address',
                  initialValue: pickedAddress.formattedAddress,
                  decoration: InputDecoration(
                    labelText: "Address",
                    hintText: "Enter address of your store",
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(3),
                  ],
                  maxLines: 2,
                ),
                SizedBox(height: getUiHeight(10)),
                FormBuilderTextField(
                  attribute: 'id_card_no',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "ID Card",
                    hintText: "Enter your ID card number",
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultButton(
          press: () async {
            try {
              if (_fbKey.currentState.saveAndValidate()) {
                var data = _fbKey.currentState.value;
                data['lat'] = pickedAddress.latitude.toString();
                data['lng'] = pickedAddress.longitude.toString();
                var response = await RestApi().post('/store', data);
                print("$response");
                if (response.containsKey('status') && response['status']) {
                  await Auth().refreshUser();
                  Get.snackbar("Success", "Store created successfully",
                      snackPosition: SnackPosition.BOTTOM);
                  Navigator.popUntil(context, (route) => route.isFirst);
                } else {
                  String _errors = "";
                  response['error'].forEach((key, value) {
                    _errors += value[0] + "\n";
                  });
                  Get.snackbar(
                    "Error!",
                    _errors,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.orange.withOpacity(0.3),
                  );
                }
              }
            } catch (e) {
              Get.snackbar("Error!", "$e", snackPosition: SnackPosition.BOTTOM);
            }
          },
          text: "Create Store",
        ),
      ),
    );
  }
}
