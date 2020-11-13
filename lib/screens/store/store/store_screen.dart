import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_or_swap/bloc/token_auth.dart';
import 'package:sell_or_swap/components/background_tile.dart';
import 'package:sell_or_swap/components/list_menu_tile.dart';
import 'package:sell_or_swap/models/user.dart';
import 'package:sell_or_swap/screens/profile/profile_screen.dart';
import 'package:sell_or_swap/screens/sell_category/sell_categories_screen.dart';
import 'package:sell_or_swap/screens/store/item/store_item_index.dart';
import 'package:sell_or_swap/size_config.dart';

class StoreScreen extends StatelessWidget {
  User _user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getUiWidth(15)),
        child: Column(
          children: [
            SizedBox(height: getUiHeight(10)),
            Container(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: getUiHeight(25)),
                    width: double.infinity,
                    child: BackgroundTile(
                      child: Container(
                        margin: EdgeInsets.only(top: getUiHeight(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Address",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.grey.shade200),
                            ),
                            Container(
                              child: Flexible(
                                child: Text(
                                  "${_user.store.address}",
                                  maxLines: 3,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getUiWidth(15)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: getUiWidth(70),
                          height: getUiWidth(70),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(getUiWidth(20)),
                            child: CachedNetworkImage(
                              imageUrl: _user.store.logo ??
                                  "https://randomuser.me/api/portraits/men/97.jpg",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(width: getUiWidth(10)),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${_user.store.name}",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text("${_user.store.idCardNo}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getUiHeight(20)),
            Expanded(
              child: ListView(
                children: [
                  ListMenuTile(
                    title: "Create Product",
                    subTitle: "Create new product here",
                    icon: Icons.add,
                    onTap: () => Get.to(SellCategoryScreen()),
                  ),
                  ListMenuTile(
                    title: "Edit",
                    subTitle: "Edit products",
                    icon: Icons.edit,
                    onTap: () => Get.to(StoreItemIndex()),
                  ),
                  ListMenuTile(
                    title: "Store Update",
                    subTitle: "Update Store Information",
                    icon: Icons.info,
                    onTap: () => Get.to(ProfileScreen()),
                  ),
                  ListMenuTile(
                    title: "Swap Items",
                    subTitle: "Swap Items",
                    icon: Icons.swap_calls,
                    onTap: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
