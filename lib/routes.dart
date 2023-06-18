import 'package:flutter/material.dart';
import 'package:homerent/auth/screens/login_view.dart';
import 'package:homerent/auth/screens/sign_up_view.dart';

class AppRouter {
  Route? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => LoginView(),
        );

      case SignUpView.routeName:
        return MaterialPageRoute(
          builder: (_) => SignUpView(),
        );

      default:
        return null;
    }
  }
}