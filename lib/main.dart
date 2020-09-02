import 'package:flutter/material.dart';
import 'package:sell_or_swap/routes.dart';
import 'package:sell_or_swap/screens/onboarding/onboard_screen.dart';
import 'package:sell_or_swap/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS App',
      theme: theme(),
      home: OnboardinScreen(),
      onGenerateRoute: RouterGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
