import 'dart:convert';
import 'package:sell_or_swap/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:sell_or_swap/networking/rest_api.dart';

class UserRepository {
  Future<Map<String, dynamic>> login(dynamic body) async {
    final response = await RestApi().post("/login", body);
    return response;
  }

  Future<List<User>> getUsers() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/users');
    List _users = jsonDecode(response.body);
    return List.generate(
        _users.length, (index) => User.fromJson(_users[index]));
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
