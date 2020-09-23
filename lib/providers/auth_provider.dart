import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sell_or_swap/models/user.dart';

enum AuthStatus {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Onboarding
}

class AuthProvider extends ChangeNotifier {
  SharedPreferences _sharedPreferences;
  AuthStatus _authStatus = AuthStatus.Uninitialized;
  User _user;
  bool _isBusy = false;
  AuthStatus get authStatus => _authStatus;
  User get user => _user;
  bool get isBusy => _isBusy;

  AuthProvider() {
    initAuth();
  }
  initAuth() async {
    try {
      print("Init AuthProvider");
      _sharedPreferences = await SharedPreferences.getInstance();
      _authStatus = AuthStatus.Unauthenticated;
      if (_sharedPreferences.containsKey('AuthToken') &&
          _sharedPreferences.getString('AuthToken') != null) {
        _authStatus = AuthStatus.Authenticated;
        _user =
            User.fromJson(json.decode(_sharedPreferences.getString('user')));
      } else if (!_sharedPreferences.containsKey('onboarding')) {
        _authStatus = AuthStatus.Onboarding;
      }
    } catch (e) {
      print("Expection: $e");
    }
    notifyListeners();
  }

  setOnBoardingComplete(bool value) {
    _sharedPreferences.setBool('onboarding', value);
  }

  Future<void> doLogin(Map<String, dynamic> data) async {
    _authStatus = AuthStatus.Authenticated;
    _sharedPreferences.setString('AuthToken', data['data']['token']);
    _user = User.fromJson(data['data']['user']);
    _sharedPreferences.setString('user', jsonEncode(data['data']['user']));
    notifyListeners();
  }

  logout() {
    _sharedPreferences.remove('AuthToken');
    _sharedPreferences.remove('user');
    _authStatus = AuthStatus.Unauthenticated;
    notifyListeners();
  }
}
