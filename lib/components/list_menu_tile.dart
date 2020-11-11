import 'package:flutter/material.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/size_config.dart';

class ListMenuTile extends StatelessWidget {
  final Function onTap;
  final String title;
  final String subTitle;
  final IconData icon;

  const ListMenuTile(
      {Key key, this.onTap, this.title, this.subTitle, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(getUiHeight(15)),
        child: Container(
          width: getUiWidth(80),
          height: getUiWidth(80),
          alignment: Alignment.center,
          color: kPrimaryColor,
          child: Icon(icon, color: Colors.white),
        ),
      ),
      title: Text(
        "$title",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("$subTitle"),
      onTap: onTap,
    );
  }
}
