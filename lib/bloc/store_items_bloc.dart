import 'dart:async';
import 'package:sell_or_swap/models/item.dart';
import 'package:sell_or_swap/networking/api_response.dart';
import 'package:sell_or_swap/repository/store_repository.dart';

class StoreItemsBloc {
  StoreRepository _storeRepository;
  StreamController _storeItemStreamController;

  StreamSink<Response<List<Item>>> get soteItemsSink =>
      _storeItemStreamController.sink;
  Stream<Response<List<Item>>> get storeItemStream =>
      _storeItemStreamController.stream;

  StoreItemsBloc(int storeId) {
    _storeItemStreamController =
        StreamController<Response<List<Item>>>.broadcast();
    _storeRepository = StoreRepository();
    getStoreItem(storeId);
  }

  Future<void> getStoreItem(int storeId) async {
    soteItemsSink.add(Response.loading("Geting Items."));
    try {
      List _users = await _storeRepository.getStoreItems(storeId);
      if (_users.length == 0) {
        soteItemsSink.add(Response.empty("No Items Found"));
      } else {
        soteItemsSink.add(Response.completed(_users));
      }
    } catch (e) {
      soteItemsSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _storeItemStreamController?.close();
  }
}
