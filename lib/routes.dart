import 'package:flutter/material.dart';
import 'package:sell_or_swap/screens/buyer_show_item/buyer_show_item_screen.dart';
import 'package:sell_or_swap/screens/chat/chat_screen.dart';
import 'package:sell_or_swap/screens/chat_home/chat_home_screen.dart';
import 'package:sell_or_swap/screens/map_add_product/map_add_product_screen.dart';
import 'package:sell_or_swap/screens/profile/profile_screen.dart';
import 'package:sell_or_swap/screens/sell_category/sell_categories_screen.dart';
import 'package:sell_or_swap/screens/seller_shop/seller_shop_screen.dart';
import 'package:sell_or_swap/screens/selling/selling_screen.dart';
import 'package:sell_or_swap/screens/signin/signin_screen.dart';
import 'package:sell_or_swap/screens/signup/signup_screen.dart';
import 'package:sell_or_swap/screens/store/item/store_item_create.dart';

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
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/chat':
        return MaterialPageRoute(
          builder: (_) => ChatScreen(
            user: args,
          ),
        );
      case '/sellcategory':
        return MaterialPageRoute(builder: (_) => SellCategoryScreen());
      case '/addSellItemForm':
        return MaterialPageRoute(
          builder: (_) => StoreItemCreateScreen(
            category: args,
          ),
        );
      case '/sellerShope':
        return MaterialPageRoute(
          builder: (_) => SellerShopScreen(
            store: args,
          ),
        );
      case '/buyerShowItem':
        return MaterialPageRoute(
          builder: (_) => BuyerShowItemScreen(
            item: args,
            store: args,
          ),
        );
      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
