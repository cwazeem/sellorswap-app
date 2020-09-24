import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sell_or_swap/models/item.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/screens/buyer_show_item/buyer_show_item_screen.dart';
import 'package:sell_or_swap/size_config.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key key,
    @required this.item,
    @required this.store,
  }) : super(key: key);

  final Item item;
  final Store store;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final route = MaterialPageRoute(
          builder: (_) => BuyerShowItemScreen(
            item: item,
            store: store,
          ),
        );
        Navigator.push(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getUiWidth(15)),
          image: DecorationImage(
            image: CachedNetworkImageProvider(item.image),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: getUiHeight(10),
              left: getUiWidth(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.name}",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: getUiHeight(8)),
                  Text("\$${item.price}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
