import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sell_or_swap/models/store.dart';

class StoresMapScreen extends StatefulWidget {
  static const String name = "storesMapScreen";
  @override
  _StoresMapScreenState createState() => _StoresMapScreenState();
}

class _StoresMapScreenState extends State<StoresMapScreen> {
  @override
  void initState() {
    super.initState();
  }

  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future<bool> handlePermission() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/marker.png');
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
  Completer<GoogleMapController> _controller = Completer();
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
              return GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: LatLng(9.506508, -0.955140),
                  zoom: 12,
                ),
                indoorViewEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  _stores.forEach((element) {
                    setMarker(element);
                  });
                },
                markers: Set<Marker>.of(markers.values),
              );
            }
            return Center(
              child: Text("Permission not granted"),
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
