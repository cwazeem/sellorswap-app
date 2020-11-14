import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sell_or_swap/components/loadin_modal.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/repository/store_repository.dart';
import 'package:sell_or_swap/size_config.dart';
import 'package:sell_or_swap/models/maps_helper.dart';
import 'components/store_map_card.dart';

class StoresMapScreen extends StatefulWidget {
  static const String name = "storesMapScreen";
  final Function loadStores;

  const StoresMapScreen({Key key, this.loadStores}) : super(key: key);
  @override
  _StoresMapScreenState createState() => _StoresMapScreenState();
}

class _StoresMapScreenState extends State<StoresMapScreen> {
  // Location Services
  Location _location = new Location();

  // Google Maps Variables
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  Completer<GoogleMapController> _googleMapController = Completer();
  MarkerId _myLocationMarkerId = MarkerId("my-location");
  BitmapDescriptor _sellerIcon;
  BitmapDescriptor _topSellerIcon;
  BitmapDescriptor _mylocationIcon;
  LatLng _lastLocation;
  bool loading = false;

  // Data repo and variables
  StoreRepository _storeRepository;
  List<Store> _stores = [];
  @override
  void initState() {
    super.initState();
    _storeRepository = StoreRepository();
    initMapComponents();
  }

  initMapComponents() async {
    _sellerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/seller_marker.png');
    _topSellerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/top_seller_marker.png');
    _mylocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/pin.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LoadingModal(
          loading: loading,
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<LocationData>(
                  future: _location.getLocation(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("ERROR : ${snapshot.error}"));
                    }
                    return Stack(
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              snapshot.data.latitude,
                              snapshot.data.longitude,
                            ),
                            zoom: 15,
                          ),
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          buildingsEnabled: true,
                          mapToolbarEnabled: true,
                          trafficEnabled: true,
                          padding: EdgeInsets.only(bottom: getUiHeight(130)),
                          onMapCreated: (GoogleMapController controller) {
                            _googleMapController.complete(controller);
                            controller.setMapStyle(mapsStyle);
                            updateMyLocation(
                              snapshot.data.latitude,
                              snapshot.data.longitude,
                            );
                            _lastLocation = LatLng(snapshot.data.latitude,
                                snapshot.data.longitude);
                          },
                          markers: Set<Marker>.of(_markers.values),
                          onCameraMove: onCameraMove,
                          onCameraIdle: () async {
                            setState(() {
                              loading = true;
                            });
                            await Future.delayed(Duration(seconds: 1));
                            getNearStores(
                              _lastLocation.latitude,
                              _lastLocation.longitude,
                            );
                            setState(() {
                              loading = false;
                            });
                          },
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCameraMove(CameraPosition position) {
    _lastLocation = position.target;
    updateMyLocation(position.target.latitude, position.target.longitude);
  }

  void updateMyLocation(double lat, double lng) {
    if (mounted) {
      setState(() {
        _markers[_myLocationMarkerId] = Marker(
          markerId: _myLocationMarkerId,
          position: LatLng(lat, lng),
          icon: _mylocationIcon,
        );
      });
    }
  }

  Future<void> getNearStores(double lat, double lng) async {
    if (mounted) {
      List<Store> stores = await _storeRepository.getNearStore(lat, lng, 10);
      _stores = stores;
      _markers
          .removeWhere((key, value) => value.markerId != _myLocationMarkerId);
      _stores.forEach((element) {
        setMarker(element);
      });
      widget.loadStores(_stores);
    }
  }

  setMarker(Store store) {
    final Marker marker = Marker(
      markerId: MarkerId(store.id.toString()),
      position:
          LatLng(store.location.coordinates[1], store.location.coordinates[0]),
      infoWindow: InfoWindow(
        title: store.name,
        snippet: '${store.address}',
        onTap: () {
          Navigator.pushNamed(context, "/sellerShope", arguments: store);
        },
      ),
      icon: store.topSeller == 1 ? _topSellerIcon : _sellerIcon,
    );
    if (mounted) {
      setState(() {
        _markers[MarkerId(store.id.toString())] = marker;
      });
    }
  }
}
