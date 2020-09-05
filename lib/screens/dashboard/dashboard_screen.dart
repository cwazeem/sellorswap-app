import 'package:flutter/material.dart';
import 'package:sell_or_swap/components/menu_tile.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/screens/dashboard/components/sell_find_seller.dart';
import 'package:sell_or_swap/screens/dashboard/components/swap_find_swapper.dart';
import 'package:sell_or_swap/size_config.dart';

import 'components/app_drawer.dart';

class DashBoardScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getUiWidth(20)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuTile(
                    icon: Icons.local_offer,
                    title: "Sell",
                    onTap: () => _scaffoldKey.currentState
                        .showBottomSheet((context) => SellOrFindSeller()),
                  ),
                  MenuTile(
                    icon: Icons.swap_horizontal_circle,
                    title: "Swap",
                    onTap: () => _scaffoldKey.currentState
                        .showBottomSheet((context) => SwapOrFindSwapper()),
                  )
                ],
              ),
              SizedBox(
                height: getUiHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuTile(
                    icon: Icons.supervised_user_circle,
                    title: "Profile",
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  MenuTile(
                    icon: Icons.message,
                    title: "Messenger",
                    onTap: () {
                      Navigator.pushNamed(context, '/chathome');
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
