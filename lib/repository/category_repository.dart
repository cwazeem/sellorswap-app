import 'dart:convert';

import 'package:sell_or_swap/models/category.dart';
import 'package:sell_or_swap/networking/api_provider.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  ApiProvider _provider = ApiProvider();

  Future<Map<String, dynamic>> login(dynamic body) async {
    final response = await _provider.post("/login", body);
    return response;
  }

  Future<List<AppCategory>> getCategories() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums');
    List _users = jsonDecode(response.body);
    return List.generate(
        _users.length, (index) => AppCategory.fromJson(_users[index]));
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
