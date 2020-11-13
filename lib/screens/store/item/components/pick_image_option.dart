import 'package:flutter/material.dart';
import 'package:sell_or_swap/components/option_menu_button.dart';
import 'package:sell_or_swap/size_config.dart';

class PickImageOption extends StatelessWidget {
  final Function onCameraTap;
  final Function onGallaryTap;

  const PickImageOption({Key key, this.onCameraTap, this.onGallaryTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(getUiWidth(20)),
        topRight: Radius.circular(getUiWidth(20)),
      ),
      child: Container(
        height: getUiHeight(130),
        padding: EdgeInsets.all(getUiWidth(20)),
        child: Row(
          children: [
            OptionMenuButton(
              icon: Icons.camera_alt,
              title: "Camera",
              onTap: onCameraTap,
            ),
            SizedBox(
              width: getUiWidth(20),
            ),
            OptionMenuButton(
              icon: Icons.image,
              title: "Gallary",
              onTap: onGallaryTap,
            ),
          ],
        ),
      ),
    );
  }
}
