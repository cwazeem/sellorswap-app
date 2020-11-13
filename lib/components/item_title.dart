import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sell_or_swap/models/item.dart';
import 'package:sell_or_swap/screens/buyer_show_item/buyer_show_item_screen.dart';
import 'package:sell_or_swap/size_config.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final route = MaterialPageRoute(
          builder: (_) => BuyerShowItemScreen(
            item: item,
          ),
        );
        Navigator.push(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getUiWidth(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: item.image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 5),
            Text("${item.category.name}"),
            Text("${item.name}"),
            Text("${item.description}"),
          ],
        ),
        // child: Stack(
        //   fit: StackFit.expand,
        //   children: [
        //     Positioned(
        //       bottom: getUiHeight(10),
        //       left: getUiWidth(10),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             "${item.name}",
        //             style: Theme.of(context).textTheme.subtitle1,
        //           ),
        //           SizedBox(height: getUiHeight(8)),
        //           Text("\$${item.price}"),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
