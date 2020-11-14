import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sell_or_swap/providers/auth_provider.dart';
import 'package:sell_or_swap/screens/create_store/picklocation/pickup_address.dart';
import 'package:sell_or_swap/bloc/token_auth.dart';
import 'package:sell_or_swap/components/cache_image.dart';
import 'package:sell_or_swap/screens/profile/profile_screen.dart';
import 'package:sell_or_swap/screens/store/store/store_screen.dart';
import 'package:sell_or_swap/screens/view_stores/view_stores_screen.dart';
import 'package:share/share.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRepo>(
      builder: (context, value, child) {
        return Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture:
                    CustomeCacheImage(image: value.user.avatar),
                accountName: Text(
                  "${value.user.name}",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                accountEmail: Text("${value.user.email}"),
              ),
              ListTile(
                title: Text(
                  "Start Sell",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.shopping_basket),
                onTap: () {
                  Navigator.pop(context);
                  if (value.user.store == null) {
                    Get.to(StoreLocationPickupScreen());
                  } else {
                    Get.to(StoreScreen());
                  }
                },
              ),
              ListTile(
                title: Text(
                  "View Stores",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.store),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(ViewStoresScreen());
                },
              ),
              ListTile(
                title: Text(
                  "My Swaps",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.swap_horiz),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  "Messages",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.messenger),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/chathome',
                    arguments: value.user.store,
                  );
                },
              ),
              ListTile(
                title: Text(
                  "Profile",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.supervised_user_circle),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(ProfileScreen());
                },
              ),
              ListTile(
                title: Text(
                  "Share App",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.share),
                onTap: () {
                  Share.share('check out my application palystore link here');
                },
              ),
              ListTile(
                title: Text(
                  "Logout",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pop(context);
                  Auth().logout();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
