import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/size_config.dart';

class StoreMapCard extends StatelessWidget {
  final GoogleMapController controller;
  final Store store;

  const StoreMapCard({Key key, this.controller, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 270.0,
              target: LatLng(store.lat, store.long),
              tilt: 30.0,
              zoom: 17.0,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(getUiWidth(15)),
            width: getUiWidth(150),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(getUiWidth(10)),
            ),
            margin: EdgeInsets.only(left: getUiHeight(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${store.name}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                ),
                SizedBox(height: getUiHeight(10)),
                Text(
                  "${store.addresss}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 10,
            child: Container(
              height: getUiHeight(25),
              padding: EdgeInsets.all(getUiWidth(5)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(getUiWidth(5)),
                  bottomRight: Radius.circular(getUiWidth(5)),
                ),
              ),
              child: Center(
                child: Text("Verified"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
