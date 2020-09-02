import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class OnbaordContent extends StatelessWidget {
  const OnbaordContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "SELL OR SWAP",
          style: TextStyle(
            fontSize: getUiWidth(36),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(),
        Image.asset(
          image,
          height: getUiHeight(265),
          width: getUiWidth(235),
        ),
      ],
    );
  }
}
