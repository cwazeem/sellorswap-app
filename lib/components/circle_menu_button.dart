import 'package:flutter/material.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/size_config.dart';

class CircleMenuButton extends StatelessWidget {
  const CircleMenuButton({
    Key key,
    this.onTap,
    this.title,
    this.icon,
  }) : super(key: key);

  final Function onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getUiWidth(60),
      height: getUiWidth(60),
      child: Material(
        borderRadius: BorderRadius.circular(getUiWidth(50)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(getUiWidth(50)),
          child: Padding(
            padding: EdgeInsets.all(getUiWidth(10)),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: getUiWidth(20),
                  color: kPrimaryColor,
                ),
                SizedBox(height: getUiHeight(5)),
                Center(
                  child: Text(
                    "$title",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: getUiWidth(8)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
