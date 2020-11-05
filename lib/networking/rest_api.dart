import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sell_or_swap/bloc/token_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_exception.dart';

class RestApi {
  static get instance => _singleton;
  static final RestApi _singleton = RestApi._internal();

  factory RestApi() {
    return _singleton;
  }
  RestApi._internal() {
    _initState();
  }

  // Rest API functions and Variables
  final String _baseUrl = "https://www.sellorswap.place/api";
  String _token;
  SharedPreferences _prefs;

  Future<String> _getToken() async {
    _token = _prefs.getString("token") ?? null;
    return _token;
  }

  _initState() async {
    _prefs = await SharedPreferences.getInstance();
    _token = await _getToken();
  }

  // Header for ResApi
  Map<String, String> _commonHeader() {
    return {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
      HttpHeaders.acceptHeader: 'application/json',
    };
  }

  Future<dynamic> get(String url, {bool isAuth = false}) async {
    var responseJson;
    try {
      http.Response httpResponse;
      if (isAuth) {
        _token = _token == null ? _token = await _getToken() : _token;
        httpResponse = await http
            .get(_baseUrl + url, headers: _commonHeader())
            .timeout(Duration(seconds: 10));
      } else {
        httpResponse =
            await http.get(_baseUrl + url).timeout(Duration(seconds: 10));
      }

      responseJson = _response(httpResponse);
    } on SocketException {
      Get.snackbar("Error!", "Internet not connected");
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body, {bool isAuth = false}) async {
    var responseJson;
    try {
      http.Response httpResponse;
      if (isAuth) {
        _token = _token == null ? _token = await _getToken() : _token;
        httpResponse = await http
            .post(_baseUrl + url, headers: _commonHeader(), body: body)
            .timeout(Duration(seconds: 10));
      }
      httpResponse = await http
          .post(_baseUrl + url, body: body)
          .timeout(Duration(seconds: 10));
      responseJson = _response(httpResponse);
    } on SocketException {
      Get.snackbar("Error!", "Internet not connected");
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body, {bool isAuth = false}) async {
    var responseJson;
    try {
      http.Response _httpResponse;
      if (isAuth) {
        _token = _token == null ? _token = await _getToken() : _token;
        _httpResponse = await http
            .put(_baseUrl + url, headers: _commonHeader(), body: body)
            .timeout(Duration(seconds: 10));
      }
      _httpResponse = await http
          .put(_baseUrl + url, body: body)
          .timeout(Duration(seconds: 10));
      responseJson = _response(_httpResponse);
    } on SocketException {
      Get.snackbar("Error!", "Internet not connected");
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    print(
        "Api Response: Status Code: ${response.statusCode} => ${response.body}");
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        Get.snackbar("Error!", "Bad request");
        throw BadRequestException(response.body.toString());
        break;
      case 401:
      case 403:
        Get.snackbar("Error!", "Unautorized access");
        Auth().logout();
        throw UnauthorisedException(response.body.toString());
        break;
      case 500:
      default:
        print("${response.body}");
        Get.snackbar("Error!", "Fatel Error");
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
