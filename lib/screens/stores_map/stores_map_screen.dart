import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/repository/store_repository.dart';
import 'package:sell_or_swap/screens/stores_map/components/app_drawer.dart';
import 'package:sell_or_swap/size_config.dart';
import 'package:sell_or_swap/models/maps_helper.dart';
import 'components/store_map_card.dart';

class StoresMapScreen extends StatefulWidget {
  static const String name = "storesMapScreen";
  @override
  _StoresMapScreenState createState() => _StoresMapScreenState();
}

class _StoresMapScreenState extends State<StoresMapScreen> {
  String uberStyle;
  StoreRepository _storeRepository;
  List<Store> _stores = [];
  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/seller_marker.png')
        .then((value) => sellerLocationIcon = value);
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/top_seller_marker.png')
        .then((value) => topSellerLocationIcon = value);

    _loadFromAsset().then((value) {
      uberStyle = value;
    });
    _storeRepository = StoreRepository();
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
        if (mounted) setState(() {});
        return true;
      }
    } else if (_permissionGranted == PermissionStatus.granted) {
      if (mounted) setState(() {});
      return true;
    }
    return false;
  }

  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/data/uber_style.json");
  }

  // Ui Variable
  GoogleMapController _googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  BitmapDescriptor sellerLocationIcon;
  BitmapDescriptor topSellerLocationIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stores"),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(getUiWidth(30)),
              decoration: BoxDecoration(color: Colors.white),
              child: Center(child: Text("BANNER")),
            ),
            Expanded(
              child: FutureBuilder<bool>(
                future: location.serviceEnabled(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data) {
                      return FutureBuilder<PermissionStatus>(
                        future: location.hasPermission(),
                        builder: (context, permissionSnapshot) {
                          switch (permissionSnapshot.data) {
                            case PermissionStatus.granted:
                              return Stack(
                                children: [
                                  GoogleMap(
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(7.753121, -0.985663),
                                      zoom: 15,
                                    ),
                                    myLocationEnabled: true,
                                    myLocationButtonEnabled: true,
                                    buildingsEnabled: true,
                                    mapToolbarEnabled: true,
                                    trafficEnabled: true,
                                    padding: EdgeInsets.only(
                                        bottom: getUiHeight(130)),
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _googleMapController = controller;
                                      controller.setMapStyle(mapsStyle);
                                      getNearStores();
                                    },
                                    markers: Set<Marker>.of(markers.values),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    right: 10,
                                    height: getUiHeight(125),
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
                              break;
                            case PermissionStatus.denied:
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Permission not granted"),
                                  OutlineButton(
                                    onPressed: () async {
                                      await location.requestPermission();
                                      setState(() {});
                                    },
                                    child: Text("Grant Permission"),
                                  )
                                ],
                              );
                              break;
                            default:
                              return Center(
                                child: Text("Unknown"),
                              );
                          }
                        },
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Location Service not enable"),
                          OutlineButton(
                            onPressed: () async {
                              if (!await location.serviceEnabled()) {
                                await location.requestService();
                                setState(() {});
                              } else {
                                setState(() {});
                              }
                            },
                            child: Text("Enable Service"),
                          )
                        ],
                      );
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getNearStores() async {
    List<Store> stores = await _storeRepository.getNearStore(0.0, 0.0, 10);
    setState(() {
      _stores = stores;
    });
    _stores.forEach((element) {
      setMarker(element);
    });
  }

  setMarker(Store store) {
    final Marker marker = Marker(
      markerId: MarkerId(store.id.toString()),
      position:
          LatLng(store.location.coordinates[1], store.location.coordinates[0]),
      infoWindow: InfoWindow(
        title: store.name,
        snippet: '*',
        onTap: () {
          Navigator.pushNamed(context, "/sellerShope", arguments: store);
        },
      ),
      icon: store.topSeller == 1 ? topSellerLocationIcon : sellerLocationIcon,
    );
    setState(() {
      markers[MarkerId(store.id.toString())] = marker;
    });
  }
}
