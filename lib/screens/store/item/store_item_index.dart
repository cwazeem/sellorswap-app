import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sell_or_swap/bloc/token_auth.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:sell_or_swap/models/item.dart';
import 'package:sell_or_swap/repository/store_repository.dart';
import 'package:sell_or_swap/components/item_title.dart';
import 'package:sell_or_swap/screens/store/item/store_item_edit.dart';

// ignore: must_be_immutable
class StoreItemIndex extends StatelessWidget {
  final StoreRepository _repo = StoreRepository();
  int storeId = Auth().currentUser.store.id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FutureBuilder<List<Item>>(
          future: _repo.getStoreItems(storeId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  return ItemTile(
                    item: snapshot.data[index],
                    ontap: () => Get.to(
                      StoreItemEditScreen(item: snapshot.data[index]),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            return Center(
              child: LoadingBouncingGrid.circle(
                borderColor: Colors.cyan,
                backgroundColor: Colors.cyan,
                size: 50.0,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildGridItem(Item item) {
    return Container(
      decoration: BoxDecoration(),
      child: Text(item.name),
    );
  }
}
