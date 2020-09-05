import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_or_swap/providers/auth_provider.dart';
import 'package:sell_or_swap/size_config.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(getUiWidth(10)),
              child: CachedNetworkImage(
                  imageUrl: "https://randomuser.me/api/portraits/women/2.jpg"),
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
    );
  }
}