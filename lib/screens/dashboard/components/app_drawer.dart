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
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(getUiWidth(10)),
                  child: CachedNetworkImage(imageUrl: "${value.user.avatar}"),
                ),
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
                trailing: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<AuthProvider>(context, listen: false).logout();
                },
              ),
              ListTile(
                title: Text(
                  "View Stores",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<AuthProvider>(context, listen: false).logout();
                },
              ),
              ListTile(
                title: Text(
                  "My Swaps",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<AuthProvider>(context, listen: false).logout();
                },
              ),
              ListTile(
                title: Text(
                  "Messages",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<AuthProvider>(context, listen: false).logout();
                },
              ),
              ListTile(
                title: Text(
                  "Profile",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<AuthProvider>(context, listen: false).logout();
                },
              ),
              ListTile(
                title: Text(
                  "Share App",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.exit_to_app),
                onTap: () {
                  Navigator.pop(context);
                  Provider.of<AuthProvider>(context, listen: false).logout();
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
                  Provider.of<AuthProvider>(context, listen: false).logout();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
