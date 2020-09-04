import 'package:flutter/material.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/size_config.dart';

class OptionMenuButton extends StatelessWidget {
  const OptionMenuButton({
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
    return Material(
      borderRadius: BorderRadius.circular(getUiWidth(10)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(
                icon,
                size: getUiHeight(40),
                color: kPrimaryColor,
              ),
              SizedBox(height: getUiHeight(5)),
              Center(
                child: Text("$title"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
