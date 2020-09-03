import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/size_config.dart';

class SellingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              Navigator.pushNamed(context, "/chathome");
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildItem(context, "Sell some stuff!", "route"),
                  buildItem(context, "Swap my goods", "route"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, String item, String route) {
    return GestureDetector(
      onTap: () async {
        LocationResult result = await showLocationPicker(
          context, googleMapApi,
          initialCenter: LatLng(31.1975844, 29.9598339),
//                      automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
          myLocationButtonEnabled: true,
          layersButtonEnabled: true,
          // countries: ['AE', 'NG']

//                      resultCardAlignment: Alignment.bottomCenter,
        );
        if (result != null && result.address != null) {
          print(
              "result = ${result.address} : ${result.latLng.toJson().toString()}");
        }

        //Navigator.pushNamed(context, '/mapAddProduct');
      },
      child: SizedBox(
        width: SizeConfig.screenWidth / 2 - 20,
        height: SizeConfig.screenHeight / 4,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    Icons.local_grocery_store,
                    size: getUiWidth(50),
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            SizedBox(height: getUiHeight(10)),
            Center(
              child: Text(
                "$item",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
