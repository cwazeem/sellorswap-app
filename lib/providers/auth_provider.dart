import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  AuthStatus get authStatus => _authStatus;

  AuthProvider() {
    initAuth();
  }
  initAuth() async {
    try {
      print("Init AuthProvider");
      _sharedPreferences = await SharedPreferences.getInstance();
      _authStatus = AuthStatus.Unauthenticated;
      if (_sharedPreferences.containsKey('isLogin') &&
          _sharedPreferences.getBool('isLogin')) {
        _authStatus = AuthStatus.Authenticated;
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

  Future<void> doLogin(
      BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey,
      String email,
      String password) async {
    _sharedPreferences.setBool('isLogin', true);
    _authStatus = AuthStatus.Authenticated;
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
    notifyListeners();
  }

  logout() {
    _sharedPreferences.setBool('isLogin', false);
    _authStatus = AuthStatus.Unauthenticated;
    notifyListeners();
  }
}
