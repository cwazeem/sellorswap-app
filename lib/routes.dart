import 'package:flutter/material.dart';
import 'package:sell_or_swap/screens/map_add_product/map_add_product_screen.dart';
import 'package:sell_or_swap/screens/selling/selling_screen.dart';
import 'package:sell_or_swap/screens/signin/signin_screen.dart';
import 'package:sell_or_swap/screens/signup/signup_screen.dart';

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
      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
