import 'package:sell_or_swap/networking/api_provider.dart';

class ShopRepository {
  ApiProvider _provider = ApiProvider();

  // Future<List<Shop>> getShopes(double lat, double lng, int type) async {
  //   final response = await _provider.get("/shops/$lat/$lng/$type");
  //   List _shops = response;
  //   return List.generate(
  //       _shops.length, (index) => Shop.fromJson(_shops[index]));
  // }

  // Future<List<ShopMenu>> getShopMenu(String id) async {
  //   final response = await _provider.get("/shopmenu/$id");
  //   List _menus = response;
  //   print("$_menus");
  //   return List.generate(
  //       _menus.length, (index) => ShopMenu.fromJson(_menus[index]));
  // }

  // Future<Map<String, dynamic>> saveAddress(dynamic body) async {
  //   final response = await _provider.post("/address", body);
  //   return response;
  // }

  // Future<Map<String, dynamic>> updateAddress(dynamic body) async {
  //   final response = await _provider.put("/address/${body['id']}", body);
  //   return response;
  // }

  // Future<Map<String, dynamic>> getProfile() async {
  //   final response = await _provider.get("/profile");
  //   return response;
  // }
}
