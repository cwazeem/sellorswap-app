import 'package:flutter/material.dart';
import 'package:sell_or_swap/size_config.dart';

import 'components/body.dart';

class OnboardinScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // You have to call it on your starting screen
    return Scaffold(
      body: Body(),
    );
  }
}
