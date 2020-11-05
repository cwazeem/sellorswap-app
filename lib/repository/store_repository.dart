import 'package:sell_or_swap/models/item.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/networking/rest_api.dart';

class StoreRepository {
  Future<List<Store>> getNearStore(double lat, double lng, int distance) async {
    Map<String, dynamic> response =
        await RestApi().get("/store/near/7.751229/-0.98253/20", isAuth: true);
    List stores = response['data'];
    return List.generate(
        stores.length, (index) => Store.fromJson(stores[index]));
  }

  Future<List<Item>> getStoreItems(int sotreId) async {
    Map<String, dynamic> response =
        await RestApi().get("/store/$sotreId/item", isAuth: true);
    List items = response['data']['items'];
    return List.generate(items.length, (index) => Item.fromJson(items[index]));
  }
}
