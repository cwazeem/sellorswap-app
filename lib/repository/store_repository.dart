import 'dart:convert';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/networking/api_provider.dart';

class StoreRepository {
  ApiProvider _provider = ApiProvider();

  Future<List<Store>> getNearStore(double lat, double lng, int distance) async {
    Map<String, dynamic> response =
        await _provider.get("/store/near/7.751229/-0.98253/20", isAuth: true);
    List stores = response['data'];
    return List.generate(
        stores.length, (index) => Store.fromJson(stores[index]));
  }
}
