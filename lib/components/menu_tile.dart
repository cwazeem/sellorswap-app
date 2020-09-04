import 'package:flutter/material.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/size_config.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    Key key,
    this.title,
    this.icon,
    this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 5,
      borderRadius: BorderRadius.circular(getUiHeight(25)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: SizeConfig.screenHeight / 4 - 20,
          width: SizeConfig.screenWidth / 2 - 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: kPrimaryColor,
                size: getUiHeight(50),
              ),
              Text(
                "$title",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
