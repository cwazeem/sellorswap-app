import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_or_swap/providers/auth_provider.dart';
import 'package:sell_or_swap/routes.dart';
import 'package:sell_or_swap/screens/dashboard/dashboard_screen.dart';
import 'package:sell_or_swap/screens/onboarding/onboard_screen.dart';
import 'package:sell_or_swap/screens/signin/signin_screen.dart';
import 'package:sell_or_swap/screens/stores_map/stores_map_screen.dart';
import 'package:sell_or_swap/size_config.dart';
import 'package:sell_or_swap/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
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
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        switch (value.authStatus) {
          case AuthStatus.Unauthenticated:
            return SignInScreen();
            break;
          case AuthStatus.Authenticated:
            if (value.user.role == 'buyer') return StoresMapScreen();
            return DashBoardScreen();
            break;
          case AuthStatus.Uninitialized:
            // TODO: Handle this case.
            break;
          case AuthStatus.Authenticating:
            // TODO: Handle this case.
            break;
          case AuthStatus.Onboarding:
            return OnboardinScreen();
            break;
          default:
            return Scaffold(
              body: Center(
                child: Text("Default Route"),
              ),
            );
            break;
        }
        return Scaffold(
          body: Center(
            child: Text("Loading"),
          ),
        );
      },
    );
  }
}
