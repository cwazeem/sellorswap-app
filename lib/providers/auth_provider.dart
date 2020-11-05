import 'package:flutter/material.dart';
import 'package:sell_or_swap/bloc/token_auth.dart';
import 'package:sell_or_swap/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStat { FirstRun, Authenticated, Unauthenticated }

class UserRepo with ChangeNotifier {
  Auth _auth;
  AuthStat _status = AuthStat.FirstRun;
  AuthStat get status => _status;

  User _user;

  User get user => _user;

  UserRepo.instance() : _auth = Auth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  _onAuthStateChanged(User user) async {
    if (user == null) {
      _status = AuthStat.Unauthenticated;
      SharedPreferences _spf = await SharedPreferences.getInstance();
      bool _isInitFirst = _spf.getBool('isInitFirst') ?? true;
      if (_isInitFirst) {
        _status = AuthStat.FirstRun;
        await _spf.setBool('isInitFirst', false);
      }
    } else {
      _status = AuthStat.Authenticated;
      _user = user;
    }
    notifyListeners();
  }
}
