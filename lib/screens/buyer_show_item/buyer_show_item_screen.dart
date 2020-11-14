import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sell_or_swap/components/circle_menu_button.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/models/item.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class BuyerShowItemScreen extends StatelessWidget {
  final Item item;
  final Store store;

  const BuyerShowItemScreen({Key key, this.item, this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight * .35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(item.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * .22),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(getUiWidth(25)),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(
                  "\$${item.price}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(getUiWidth(25)),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.name}",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: getUiWidth(20)),
                  Container(
                    height: SizeConfig.screenHeight * .50,
                    child: SingleChildScrollView(
                      child: Text(
                        item.description,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: Row(
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
              Navigator.pushNamed(context, '/chat', arguments: store);
            },
          ),
          CircleMenuButton(
            icon: Icons.directions,
            title: "Direction",
            onTap: () async {
              String googleUrl =
                  'https://www.google.com/maps/search/?api=1&query=${store.location.coordinates[1]},${store.location.coordinates[0]}';
              if (await canLaunch(googleUrl)) {
                await launch(googleUrl);
              } else {
                Get.snackbar('Error!', 'Could not open the map.');
              }
            },
          )
        ],
      ),
    );
  }
}
