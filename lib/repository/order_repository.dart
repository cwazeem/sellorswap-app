import 'package:sell_or_swap/networking/api_provider.dart';

class OrderRepository {
  ApiProvider _provider = ApiProvider();

  // Future<dynamic> create(dynamic body) async {
  //   final response = await _provider.post("/order", body);
  //   return response;
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
