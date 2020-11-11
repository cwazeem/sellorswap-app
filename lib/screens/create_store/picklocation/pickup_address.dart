import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/models/address_from_geocode.dart';
import 'package:sell_or_swap/models/maps_helper.dart';
import 'package:sell_or_swap/screens/create_store/create_store_screen.dart';
import 'package:sell_or_swap/size_config.dart';
import 'components/address_card.dart';
import 'package:http/http.dart' as http;
import 'package:sell_or_swap/components/default_button.dart';

class StoreLocationPickupScreen extends StatefulWidget {
  @override
  _StoreLocaitonPickupScreenState createState() =>
      _StoreLocaitonPickupScreenState();
}

class _StoreLocaitonPickupScreenState extends State<StoreLocationPickupScreen> {
  // Location Services
  Location _location = new Location();

  // Google Maps Variables
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  Completer<GoogleMapController> _googleMapController = Completer();
  MarkerId _markerId = MarkerId("my-location");
  BitmapDescriptor _markerIcon;

  Future _myLoactionFuture;

  // Pickup Locaiton
  AddressFromGeoCode _pickupAddress;
  LatLng _lastPickupAddress;

  @override
  void initState() {
    super.initState();
    _myLoactionFuture = _location.getLocation();
    setMarker();
  }

  setMarker() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/seller_marker.png",
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => mounted ? true : false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Store Location"),
          centerTitle: true,
        ),
        body: FutureBuilder<LocationData>(
          future: _myLoactionFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
              children: [
                buildGoogleMaps(snapshot.data),
                AddressCard(
                  address: _pickupAddress,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: DefaultButton(
                        press: () => Get.to(CreateStoreScreen(
                          pickedAddress: _pickupAddress,
                        )),
                        text: "Continue",
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildGoogleMaps(LocationData position) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17,
      ),
      padding: EdgeInsets.symmetric(vertical: getUiHeight(55)),
      markers: Set<Marker>.from(_markers.values),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: (GoogleMapController _controller) {
        _controller.setMapStyle(mapsStyle);
        _googleMapController.complete(_controller);
        getAddressFromLocation(position.latitude, position.longitude);
        setState(() {
          _markers[_markerId] = Marker(
            markerId: _markerId,
            position: LatLng(position.latitude, position.longitude),
            icon: _markerIcon,
          );
        });
      },
      onCameraMove: (CameraPosition _postition) {
        _lastPickupAddress = LatLng(
          _postition.target.latitude,
          _postition.target.longitude,
        );
        setState(() {
          _markers[_markerId] = _markers[_markerId].copyWith(
            positionParam: _lastPickupAddress,
          );
        });
      },
      onCameraIdle: () {
        if (_lastPickupAddress != null && mounted) {
          getAddressFromLocation(
              _lastPickupAddress.latitude, _lastPickupAddress.longitude);
        }
      },
    );
  }

  Future<void> getAddressFromLocation(double lat, double lng) async {
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleMapApi";
    try {
      http.Response _response = await http.get(url);
      print("$url");
      if (_response.statusCode == 200) {
        Map<String, dynamic> _result = jsonDecode(_response.body);
        if (_result.containsKey('results')) {
          setState(() {
            _pickupAddress = AddressFromGeoCode(
              formattedAddress: _result['results'][0]['formatted_address'],
              latitude: lat,
              longitude: lng,
            );
          });
        }
      }
    } catch (e) {
      print("$e");
    }
  }
}
