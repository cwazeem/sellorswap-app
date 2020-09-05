import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_or_swap/components/menu_tile.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/providers/auth_provider.dart';
import 'package:sell_or_swap/screens/dashboard/components/sell_find_seller.dart';
import 'package:sell_or_swap/screens/dashboard/components/swap_find_swapper.dart';
import 'package:sell_or_swap/size_config.dart';

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
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(getUiWidth(10)),
                child: CachedNetworkImage(
                    imageUrl:
                        "https://randomuser.me/api/portraits/women/2.jpg"),
              ),
              accountName: Text(
                "Ana Jaiay",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6,
              ),
              accountEmail: Text("anajaiy@gmail.com"),
            ),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(context);
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
            )
          ],
        ),
      ),
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
