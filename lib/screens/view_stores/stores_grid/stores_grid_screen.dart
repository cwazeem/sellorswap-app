import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_or_swap/components/store_title.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/screens/seller_shop/seller_shop_screen.dart';

class StoresGridScreen extends StatelessWidget {
  final List<Store> stores;

  const StoresGridScreen({Key key, this.stores}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: GridView.builder(
        itemCount: stores.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.72,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return StoreTile(
            item: stores[index],
            ontap: () {
              Get.to(SellerShopScreen(
                store: stores[index],
              ));
            },
          );
        },
      ),
    );
  }
}
