import 'dart:async';
import 'package:sell_or_swap/models/category.dart';
import 'package:sell_or_swap/networking/api_response.dart';
import 'package:sell_or_swap/repository/category_repository.dart';

class CategoriesBloc {
  CategoryRepository _categoryRepository;
  StreamController _categoryStreamController;

  StreamSink<Response<List<AppCategory>>> get categorySink =>
      _categoryStreamController.sink;
  Stream<Response<List<AppCategory>>> get categoriesListStream =>
      _categoryStreamController.stream;

  CategoriesBloc() {
    _categoryStreamController =
        StreamController<Response<List<AppCategory>>>.broadcast();
    _categoryRepository = CategoryRepository();
    getUsers();
  }

  Future<void> getUsers() async {
    categorySink.add(Response.loading("Geting users."));
    try {
      List _users = await _categoryRepository.getCategories();
      if (_users.length == 0) {
        categorySink.add(Response.empty("No Users Found"));
      } else {
        categorySink.add(Response.completed(_users));
      }
    } catch (e) {
      categorySink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _categoryStreamController?.close();
  }
}
