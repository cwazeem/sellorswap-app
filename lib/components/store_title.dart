import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/size_config.dart';

class StoreTile extends StatelessWidget {
  const StoreTile({
    Key key,
    this.ontap,
    @required this.item,
  }) : super(key: key);

  final Store item;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getUiWidth(15)),
          color: Colors.grey.shade200,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(getUiWidth(15)),
                topRight: Radius.circular(getUiWidth(15)),
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: item.logo,
                    fit: BoxFit.contain,
                  ),
                  item.topSeller == 1
                      ? Positioned(
                          top: 0,
                          right: 10,
                          child: Container(
                            height: getUiHeight(28),
                            padding: EdgeInsets.all(getUiWidth(5)),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(getUiWidth(5)),
                                bottomLeft: Radius.circular(getUiWidth(5)),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Top-Seller",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Text(
                      "${item.name}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Text(
                    "${item.address}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
