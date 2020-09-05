import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/size_config.dart';

import 'components/store_map_card.dart';

class StoresMapScreen extends StatefulWidget {
  static const String name = "storesMapScreen";
  @override
  _StoresMapScreenState createState() => _StoresMapScreenState();
}

class _StoresMapScreenState extends State<StoresMapScreen> {
  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/marker.png')
        .then((value) => pinLocationIcon = value);
  }

  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  Future<bool> handlePermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return true;
      }
    } else if (_permissionGranted == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  // Ui Variable
  GoogleMapController _googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  BitmapDescriptor pinLocationIcon;
  List<Store> _stores = [
    Store(
        id: 1,
        name: 'Kashana',
        addresss: 'Hajjjslfsd 2',
        lat: 9.376986,
        long: -0.825010),
    Store(
        id: 2,
        name: 'Kapil',
        addresss: 'Ring Road 25, Ghana',
        lat: 9.458633,
        long: -1.004107),
    Store(
        id: 3,
        name: 'Humanan',
        addresss: 'Kalony, 5, House 8',
        lat: 9.566098,
        long: -0.940377),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stores"),
        centerTitle: true,
      ),
      body: FutureBuilder<bool>(
        future: handlePermission(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(9.506508, -0.955140),
                      zoom: 12,
                    ),
                    indoorViewEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    padding: EdgeInsets.only(bottom: getUiHeight(130)),
                    onMapCreated: (GoogleMapController controller) {
                      _googleMapController = controller;
                      _stores.forEach((element) {
                        setMarker(element);
                      });
                    },
                    markers: Set<Marker>.of(markers.values),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    height: getUiHeight(120),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _stores.length,
                      itemBuilder: (context, index) {
                        return StoreMapCard(
                          controller: _googleMapController,
                          store: _stores[index],
                        );
                      },
                    ),
                  )
                ],
              );
            }
            return Column(
              children: [
                Text("Permission not granted"),
                OutlineButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text("Grant Permission"),
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  setMarker(Store store) {
    final Marker marker = Marker(
      markerId: MarkerId(store.id.toString()),
      position: LatLng(store.lat, store.long),
      infoWindow: InfoWindow(title: store.name, snippet: '*'),
      icon: pinLocationIcon,
      onTap: () {
        print("Stroe id: ${store.id}");
      },
    );
    setState(() {
      markers[MarkerId(store.id.toString())] = marker;
    });
  }
}
