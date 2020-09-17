import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:sell_or_swap/networking/custom_exception.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  final String _baseUrl = "https://www.sellorswap.place/api";

  String _token;

  Future<String> _getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString("AuthToken");
    return _token;
  }

  Map<String, String> _commonHeader() {
    return {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
      HttpHeaders.acceptHeader: 'application/json',
    };
  }

  Future<dynamic> get(String url, {bool isAuth = false}) async {
    var responseJson;
    try {
      http.Response response;
      if (isAuth) {
        _token = _token == null ? _token = await _getToken() : _token;
        response = await http
            .get(_baseUrl + url, headers: _commonHeader())
            .timeout(Duration(seconds: 10));
      } else {
        response =
            await http.get(_baseUrl + url).timeout(Duration(seconds: 10));
      }

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    var responseJson;
    try {
      _token = _token == null ? _token = await _getToken() : _token;
      print("URL: ${_baseUrl + url} : Token : $_token : Body : $body");
      final response = await http
          .post(_baseUrl + url, headers: _commonHeader(), body: body)
          .timeout(Duration(seconds: 10));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    var responseJson;
    try {
      _token = _token == null ? _token = await _getToken() : _token;
      final response = await http
          .put(_baseUrl + url, headers: _commonHeader(), body: body)
          .timeout(Duration(seconds: 10));
      responseJson = _response(response);
      print("$responseJson");
    } on SocketException {
      throw FetchDataException('No Internet connection');
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
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        print("${response.body}");
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
