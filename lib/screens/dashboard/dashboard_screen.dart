import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_or_swap/components/circle_menu_button.dart';
import 'package:sell_or_swap/providers/auth_provider.dart';
import 'package:share/share.dart';
import 'components/seller_shop_items_grid.dart';
import 'package:sell_or_swap/size_config.dart';
import 'components/app_drawer.dart';

class DashBoardScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: getUiWidth(80),
                            height: getUiWidth(80),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(getUiWidth(10)),
                              child: CachedNetworkImage(
                                imageUrl: auth.user.store.logo,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: getUiWidth(20)),
                          Column(
                            children: [
                              Text(
                                auth.user.store.name ?? "",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    auth.user.mobile ?? "",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  IconButton(
                                    iconSize: getUiWidth(18),
                                    icon: Icon(Icons.share),
                                    onPressed: () {
                                      Share.share(
                                          "Here is my store link https://sellorswap.place/store/${auth.user.store.id}");
                                    },
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: getUiHeight(20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleMenuButton(
                            icon: Icons.supervised_user_circle,
                            title: "Profile",
                            onTap: () {
                              Navigator.pushNamed(context, '/profile',
                                  arguments: auth.user.store);
                            },
                          ),
                          CircleMenuButton(
                            icon: Icons.message,
                            title: "Messenger",
                            onTap: () {
                              Navigator.pushNamed(context, '/chathome',
                                  arguments: auth.user.store);
                            },
                          ),
                          CircleMenuButton(
                            icon: Icons.add_circle,
                            title: "Add Item",
                            onTap: () {
                              Navigator.pushNamed(context, '/sellcategory',
                                  arguments: auth.user.store);
                            },
                          ),
                          CircleMenuButton(
                            icon: Icons.adjust,
                            title: "Banner",
                            onTap: () {},
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: getUiHeight(20),
                ),
                Expanded(
                  child: SellerShopGridItems(store: auth.user.store),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
