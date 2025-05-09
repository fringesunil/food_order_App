import 'package:flutter/material.dart';
import 'package:food_order_app/core/routes/routes.dart';
import 'package:food_order_app/core/routes/routes_string.dart';
import 'package:food_order_app/screens/authendication/provider/auth_provider.dart';
import 'package:food_order_app/screens/home/provider/home_provider.dart';
import 'package:food_order_app/screens/menu/provider/menu_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(),
      ),
      ChangeNotifierProvider<MenuProvider>(
        create: (_) => MenuProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.login,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
