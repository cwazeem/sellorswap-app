import 'package:flutter/material.dart';
import 'package:sell_or_swap/models/store.dart';
import 'package:sell_or_swap/screens/view_stores/stores_grid/stores_grid_screen.dart';
import 'package:sell_or_swap/screens/view_stores/stores_map/stores_map_screen.dart';
import 'package:sell_or_swap/size_config.dart';

class ViewStoresScreen extends StatefulWidget {
  @override
  _ViewStoresScreenState createState() => _ViewStoresScreenState();
}

class _ViewStoresScreenState extends State<ViewStoresScreen> {
  int _index = 0;

  List<Store> _stores;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(getUiWidth(30)),
              decoration: BoxDecoration(color: Colors.white),
              child: Center(child: Text("BANNER")),
            ),
            Expanded(
              child: IndexedStack(
                index: _index,
                children: [
                  StoresMapScreen(
                    loadStores: (List<Store> stores) {
                      setState(() {
                        _stores = stores;
                      });
                    },
                  ),
                  StoresGridScreen(
                    stores: _stores,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int x) {
          setState(() {
            _index = x;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_on), label: "Grid"),
        ],
      ),
    );
  }
}
