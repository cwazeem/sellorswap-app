import 'package:flutter/material.dart';
import 'package:sell_or_swap/components/option_menu_button.dart';
import 'package:sell_or_swap/screens/stores_map/stores_map_screen.dart';
import 'package:sell_or_swap/size_config.dart';

class SellOrFindSeller extends StatelessWidget {
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
              icon: Icons.local_offer,
              title: "Sell Item",
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/sellcategory');
              },
            ),
            SizedBox(
              width: getUiWidth(20),
            ),
            OptionMenuButton(
              icon: Icons.search,
              title: "Find Seller",
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, StoresMapScreen.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}
