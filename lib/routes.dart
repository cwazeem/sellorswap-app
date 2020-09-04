import 'package:flutter/material.dart';
import 'package:sell_or_swap/screens/add_sell_item/add_sell_item.dart';
import 'package:sell_or_swap/screens/chat/chat_screen.dart';
import 'package:sell_or_swap/screens/chat_home/chat_home_screen.dart';
import 'package:sell_or_swap/screens/map_add_product/map_add_product_screen.dart';
import 'package:sell_or_swap/screens/profile/profile_screen.dart';
import 'package:sell_or_swap/screens/sell_category/sell_categories_screen.dart';
import 'package:sell_or_swap/screens/selling/selling_screen.dart';
import 'package:sell_or_swap/screens/signin/signin_screen.dart';
import 'package:sell_or_swap/screens/signup/signup_screen.dart';
import 'package:sell_or_swap/screens/stores_map/stores_map_screen.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/selling':
        return MaterialPageRoute(builder: (_) => SellingScreen());
      case '/mapAddProduct':
        return MaterialPageRoute(builder: (_) => MapAddProductScreen());
      case '/chathome':
        return MaterialPageRoute(builder: (_) => ChatHomeScreen());
      case StoresMapScreen.name:
        return MaterialPageRoute(builder: (_) => StoresMapScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/chat':
        return MaterialPageRoute(
            builder: (_) => ChatScreen(
                  user: args,
                ));
      case '/sellcategory':
        return MaterialPageRoute(builder: (_) => SellCategoryScreen());
      case '/addSellItemForm':
        return MaterialPageRoute(
            builder: (_) => AddSellItem(
                  category: args,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
