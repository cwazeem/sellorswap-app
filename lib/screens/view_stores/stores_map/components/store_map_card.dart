import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/size_config.dart';

class StoreMapCard extends StatelessWidget {
  final Completer<GoogleMapController> controller;
  final Store store;

  StoreMapCard({Key key, this.controller, this.store}) : super(key: key);

  GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _controller = await controller.future;
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 270.0,
              target: LatLng(
                  store.location.coordinates[1], store.location.coordinates[0]),
              tilt: 30.0,
              zoom: 17.0,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(getUiWidth(8)),
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
                SizedBox(height: getUiHeight(5)),
                Text(
                  "${store.address}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),
          store.topSeller == 1
              ? Positioned(
                  bottom: 0,
                  right: 10,
                  child: Container(
                    height: getUiHeight(28),
                    padding: EdgeInsets.all(getUiWidth(5)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(getUiWidth(5)),
                        topRight: Radius.circular(getUiWidth(5)),
                      ),
                    ),
                    child: Center(
                      child: Text("Top-Seller"),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
