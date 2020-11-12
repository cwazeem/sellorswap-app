import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_or_swap/models/user.dart';
import 'package:sell_or_swap/networking/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static get instance => _singleton;
  static final Auth _singleton = Auth._internal();
  SharedPreferences _sp;
  StreamController<User> _userStreamController;
  User _user;
  User get currentUser => _user;

  factory Auth() {
    return _singleton;
  }
  Auth._internal() {
    _userStreamController = StreamController<User>();
    _initState();
  }

  _initState() async {
    _userStreamController.sink.add(null);
    _sp = await SharedPreferences.getInstance();
    String token = _sp.getString("token") ?? null;
    if (token != null) {
      _user = User.fromJson(json.decode(_sp.getString('user')));
      _userStreamController.sink.add(_user);
      refreshUser();
    }
  }

  Stream<User> authStateChanges() {
    return _userStreamController.stream;
  }

  Future<void> refreshUser() async {
    try {
      var response = await RestApi().get('/user', isAuth: true);
      if (response != null) {
        updateUser(response);
      }
    } catch (e) {
      printError(info: e);
    }
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      var response = await RestApi()
          .post("/login", {'email': email, 'password': password});
      if (response.containsKey('status') && response['status']) {
        print("${response['data']['token']}");
        _sp.setString('token', response['data']['token']);
        updateUser(response['data']['user']);
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        Get.snackbar(
          "Error!",
          "Email or password not matched",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.withOpacity(0.3),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error!",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.3),
      );
    }
  }

  Future<void> register(Map<String, dynamic> data, BuildContext context) async {
    try {
      var response = await RestApi().post("/register", data);
      if (response.containsKey('status') && response['status']) {
        await _sp.setString('token', response['data']['token']);
        updateUser(response['data']['user']);
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        String _errors = "";
        if (response.containsKey('error')) {
          Map _e = response['error'];
          _e.forEach((key, value) {
            _errors += value[0] + "\n";
          });
          Get.snackbar(
            "Error!",
            _errors,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange.withOpacity(0.3),
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error!",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.3),
      );
    }
  }

  Future<void> logout() async {
    await _sp.remove("token");
    await _sp.remove("user");
    _user = null;
    _userStreamController.sink.add(null);
  }

  void updateUser(Map<String, dynamic> user) async {
    printInfo(info: "User Update");
    _user = User.fromJson(user);
    await _sp.setString('user', jsonEncode(user));
    _userStreamController.sink.add(_user);
  }
}
