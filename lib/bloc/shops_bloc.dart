import 'dart:async';

// class ShopsBloc {
//   ShopRepository _shopRepository;
//   StreamController _shopStreamController;

//   StreamSink<Response<List<Shop>>> get shopSink => _shopStreamController.sink;
//   Stream<Response<List<Shop>>> get shopListStream =>
//       _shopStreamController.stream;

//   ShopsBloc(double lat, double lng, int type) {
//     _shopStreamController = StreamController<Response<List<Shop>>>.broadcast();
//     _shopRepository = ShopRepository();
//     getShopMenu(lat, lng, type);
//   }

//   Future<void> getShopMenu(double lat, double lng, int type) async {
//     shopSink.add(Response.loading("Geting shops."));
//     try {
//       List<Shop> _shops = await _shopRepository.getShopes(lat, lng, type);
//       if (_shops.length == 0) {
//         shopSink.add(Response.empty("No Shops Found"));
//       } else {
//         shopSink.add(Response.completed(_shops));
//       }
//     } catch (e) {
//       shopSink.add(Response.error(e.toString()));
//     }
//   }

//   dispose() {
//     _shopStreamController?.close();
//   }
// }
