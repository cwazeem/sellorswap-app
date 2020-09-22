import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sell_or_swap/components/circle_menu_button.dart';
import 'package:sell_or_swap/components/option_menu_button.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/screens/seller_shop/componenets/seller_shop_items_grid.dart';
import 'package:sell_or_swap/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerShopScreen extends StatelessWidget {
  final Store store;

  const SellerShopScreen({Key key, this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                          borderRadius: BorderRadius.circular(getUiWidth(80)),
                          child: CachedNetworkImage(
                            imageUrl: store.logo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: getUiWidth(20)),
                      Text(
                        store.name ?? "",
                        style: Theme.of(context).textTheme.headline4,
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
                        icon: Icons.phone,
                        title: "Call",
                        onTap: () async {
                          String url = 'tel:+22365985689';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                      CircleMenuButton(
                        icon: Icons.message,
                        title: "Message",
                        onTap: () {
                          Navigator.pushNamed(context, '/chat',
                              arguments: store);
                        },
                      ),
                      CircleMenuButton(
                        icon: Icons.directions,
                        title: "Direction",
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
              child: SellerShopGridItems(store: store),
            )
          ],
        ),
      ),
    );
  }
}
