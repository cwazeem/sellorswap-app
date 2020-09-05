import 'package:flutter/material.dart';
import 'package:sell_or_swap/screens/sell_items/components/item_tille.dart';

class SellItemScreen extends StatefulWidget {
  @override
  _SellItemScreenState createState() => _SellItemScreenState();
}

class _SellItemScreenState extends State<SellItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sell Items"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ItemTile(index: index),
        separatorBuilder: (context, index) => Divider(),
        itemCount: 25,
      ),
    );
  }
}
