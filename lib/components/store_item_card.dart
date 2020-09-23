import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sell_or_swap/models/item.dart';
import 'package:sell_or_swap/size_config.dart';

class StoreItemCard extends StatelessWidget {
  const StoreItemCard({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/buyerShowItem',
          arguments: item,
        );
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
            ),
            Positioned(
              right: 5,
              top: 10,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {},
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
