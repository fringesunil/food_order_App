import 'package:flutter/material.dart';
import 'package:food_order_app/core/routes/routes_string.dart';
import 'package:food_order_app/screens/authendication/pages/login_page.dart';
import 'package:food_order_app/screens/authendication/pages/signup_page.dart';
import 'package:food_order_app/screens/home/page/home_screen.dart';

class RouteGenerator {
  static MaterialPageRoute generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.login:
        return routeName(const LoginPage());
      case AppRoutes.signup:
        return routeName(const SignupPage());
      case AppRoutes.home:
        return routeName(HomeScreen());

      default:
        return routeName(const LoginPage());
    }
  }
}

MaterialPageRoute routeName(Widget route) {
  return MaterialPageRoute(builder: (_) => route);
}
