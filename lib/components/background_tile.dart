import 'package:flutter/material.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/size_config.dart';

class BackgroundTile extends StatelessWidget {
  final Widget child;

  const BackgroundTile({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getUiWidth(50)),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(getUiWidth(15)),
      ),
      child: child,
    );
  }
}
