import 'package:flutter/material.dart';

import 'package:memow/features/auth/screens/sign_in_screen.dart';
import 'package:memow/features/auth/screens/sign_up_screen.dart';

import 'package:memow/features/home_memoworld/screens/home_screen.dart';
import 'package:memow/layout/community_page.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case (SignInScreen.routeName):
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignInScreen(),
      );
    case (SignUpScreen.routeName):
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpScreen(),
      );
    case (HomeScreen.routeName):
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case (ChatPage.routeName):
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ChatPage(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not exists'),
                ),
              ));
  }
}
