import 'package:flutter/material.dart';
import 'package:sell_or_swap/bloc/categories_bloc.dart';
import 'package:sell_or_swap/models/category.dart';
import 'package:sell_or_swap/networking/api_response.dart';

import 'components/category_list.dart';

class SellCategoryScreen extends StatefulWidget {
  @override
  _SellCategoryScreenState createState() => _SellCategoryScreenState();
}

class _SellCategoryScreenState extends State<SellCategoryScreen> {
  CategoriesBloc _categoriesBloc;
  @override
  void initState() {
    super.initState();
    _categoriesBloc = CategoriesBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: StreamBuilder<Response<List<ItemCategory>>>(
        stream: _categoriesBloc.categoriesListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
                break;
              case Status.EMPTY:
                return Center(child: Text("Empty"));
                break;
              case Status.COMPLETED:
                return CategoryList(
                  categories: snapshot.data.data,
                );
                break;
              case Status.ERROR:
                return Center(
                  child: Text("Error " + snapshot.data.message),
                );
                break;
              default:
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Text("Starting.."),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _categoriesBloc.dispose();
    super.dispose();
  }
}
