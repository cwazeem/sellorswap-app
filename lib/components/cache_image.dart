import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sell_or_swap/size_config.dart';

class CustomeCacheImage extends StatelessWidget {
  const CustomeCacheImage({Key key, this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(getUiWidth(50)),
      child: CachedNetworkImage(
        imageUrl: image ?? "https://randomuser.me/api/portraits/men/20.jpg",
        fit: BoxFit.contain,
      ),
    );
  }
}
