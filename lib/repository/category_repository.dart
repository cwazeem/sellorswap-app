import 'dart:convert';

import 'package:sell_or_swap/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:sell_or_swap/networking/rest_api.dart';

class CategoryRepository {
  Future<Map<String, dynamic>> login(dynamic body) async {
    final response = await RestApi().post("/login", body);
    return response;
  }

  Future<List<AppCategory>> getCategories() async {
    final response = await RestApi().get("/category", isAuth: true);
    List _categories = response['data'];
    return List.generate(_categories.length,
        (index) => AppCategory.fromJson(_categories[index]));
  }

  // Future<Map<String, dynamic>> updateAddress(dynamic body) async {
  //   final response = await _provider.put("/address/${body['id']}", body);
  //   return response;
  // }

  // Future<Map<String, dynamic>> getProfile() async {
  //   final response = await _provider.get("/profile");
  //   return response;
  // }
}
