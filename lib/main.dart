import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sell_or_swap/networking/rest_api.dart';
import 'package:sell_or_swap/providers/auth_provider.dart';
import 'package:sell_or_swap/routes.dart';
import 'package:sell_or_swap/screens/dashboard/dashboard_screen.dart';
import 'package:sell_or_swap/screens/onboarding/onboard_screen.dart';
import 'package:sell_or_swap/screens/signin/signin_screen.dart';
import 'package:sell_or_swap/size_config.dart';
import 'package:sell_or_swap/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RestApi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserRepo>(
          create: (context) => UserRepo.instance(),
        ),
      ],
      child: GetMaterialApp(
        title: 'SOS App',
        theme: theme(),
        home: RouterScreen(),
        onGenerateRoute: RouterGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class RouterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Selector<UserRepo, AuthStat>(
      builder: (context, value, child) {
        switch (value) {
          case AuthStat.Unauthenticated:
            return SignInScreen();
          case AuthStat.Authenticated:
            return DashBoardScreen();
          default:
            return OnboardinScreen();
        }
      },
      selector: (context, repo) => repo.status,
    );
  }
}
