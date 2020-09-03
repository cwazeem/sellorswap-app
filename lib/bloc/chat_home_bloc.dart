import 'dart:async';

import 'package:sell_or_swap/models/user.dart';
import 'package:sell_or_swap/networking/api_response.dart';
import 'package:sell_or_swap/repository/user_repository.dart';

class ChatHomeBloc {
  UserRepository _userRepository;
  StreamController _userStreamController;

  StreamSink<Response<List<User>>> get shopSink => _userStreamController.sink;
  Stream<Response<List<User>>> get shopListStream =>
      _userStreamController.stream;

  ChatHomeBloc() {
    _userStreamController = StreamController<Response<List<User>>>.broadcast();
    _userRepository = UserRepository();
    getUsers();
  }

  Future<void> getUsers() async {
    shopSink.add(Response.loading("Geting users."));
    try {
      List _users = await _userRepository.getUsers();
      if (_users.length == 0) {
        shopSink.add(Response.empty("No Users Found"));
      } else {
        shopSink.add(Response.completed(_users));
      }
    } catch (e) {
      shopSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _userStreamController?.close();
  }
}
