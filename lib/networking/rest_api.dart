import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
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
  RestApi._internal();
  // Rest API functions and Variables
  final String _baseUrl = "https://www.sellorswap.place/api";
  // final String _baseUrl = "http://192.168.0.111:8000/api";
  String _token;
  SharedPreferences _prefs;

  Future<String> _getToken() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString("token") ?? null;
    return _token;
  }

  // Header for ResApi
  Map<String, String> _commonHeader() {
    return {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
      HttpHeaders.acceptHeader: 'application/json'
    };
  }

  Future<dynamic> get(String url, {bool isAuth = false}) async {
    var responseJson;
    try {
      _token = _token == null ? _token = await _getToken() : _token;
      final httpResponse =
          await http.get(_baseUrl + url, headers: _commonHeader());

      responseJson = _response(httpResponse);
    } on SocketException {
      Get.snackbar("Error!", "Internet not connected");
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body, {bool isAuth = false}) async {
    var responseJson;
    try {
      _token = _token == null ? _token = await _getToken() : _token;
      final httpResponse = await http
          .post(_baseUrl + url, headers: _commonHeader(), body: body)
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
      _token = _token == null ? _token = await _getToken() : _token;
      final httpResponse = await http
          .put(_baseUrl + url, headers: _commonHeader(), body: body)
          .timeout(Duration(seconds: 10));
      responseJson = _response(httpResponse);
    } on SocketException {
      Get.snackbar("Error!", "Internet not connected");
    }
    return responseJson;
  }

  Future<dynamic> uploadFile({File file, String filename}) async {
    var responseJson;
    try {
      _token = _token == null ? _token = await _getToken() : _token;
      Map<String, String> headers = {
        "Authorization": "Bearer $_token",
        "Content-type": "multipart/form-data"
      };
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(_baseUrl + "/image"),
      );
      request.files.add(
        http.MultipartFile(
          'image',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: filename,
        ),
      );
      request.headers.addAll(headers);
      var httpResponse = await request.send();
      print("This is response:" + httpResponse.toString());
      printInfo(info: "File Upload : ${httpResponse.statusCode}");
      httpResponse.stream.transform(utf8.decoder).listen((event) {
        return json.decode(event.toString());
      });
    } on SocketException {
      Get.snackbar("Error!", "Internet not connected");
    }
    return responseJson;
  }

  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    _token = _token == null ? _token = await _getToken() : _token;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    Dio dio = new Dio();
    Response response = await dio.post(_baseUrl + "/image",
        options: Options(
            contentType: 'multipart/form-data',
            method: 'POST',
            headers: {'Authorization': "Bearer $_token"}),
        data: formData);
    return response.data['url'];
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
