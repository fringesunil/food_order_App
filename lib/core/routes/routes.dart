import 'package:flutter/material.dart';
import 'package:food_order_app/core/routes/routes_string.dart';
import 'package:food_order_app/screens/authendication/pages/login_page.dart';
import 'package:food_order_app/screens/authendication/pages/signup_page.dart';
import 'package:food_order_app/screens/home/page/home_screen.dart';
import 'package:food_order_app/screens/menu/pages/menu_list_screen.dart';

class RouteGenerator {
  static MaterialPageRoute generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case AppRoutes.login:
        return routeName(const LoginPage());
      case AppRoutes.signup:
        return routeName(const SignupPage());
      case AppRoutes.home:
        return routeName(const HomeScreen());
      case AppRoutes.menu:
        String hotelId = '';
        if (args is List<String> && args.isNotEmpty) {
          hotelId = args[0];
        }
        return routeName(MenuListScreen(hotelId: hotelId));

      default:
        return routeName(const LoginPage());
    }
  }
}

MaterialPageRoute routeName(Widget route) {
  return MaterialPageRoute(builder: (_) => route);
}
