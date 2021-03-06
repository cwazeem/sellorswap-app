import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/models/item.dart';
import 'package:sell_or_swap/size_config.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key key,
    this.ontap,
    @required this.item,
  }) : super(key: key);

  final Item item;
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
              child: CachedNetworkImage(
                imageUrl: item.image,
                fit: BoxFit.contain,
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
                      "${item.category.name}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Text(
                    "${item.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${item.description}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "\$",
                      style: TextStyle(color: kPrimaryColor, fontSize: 18),
                      children: [
                        TextSpan(
                          text: "${item.price}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
