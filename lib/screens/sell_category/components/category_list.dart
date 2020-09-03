import 'package:flutter/material.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/models/category.dart';

class CategoryList extends StatelessWidget {
  final List<AppCategory> categories;

  const CategoryList({Key key, this.categories}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: kPrimaryColor,
            child: Text(
              "${index + 1}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            "${categories[index].title}",
            style: Theme.of(context).textTheme.headline6,
          ),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pushNamed(context, '/addSellItemForm',
                arguments: categories[index]);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
