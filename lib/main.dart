import 'package:flutter/material.dart';
import 'package:food_order_app/screens/authendication/pages/login_page.dart';
import 'package:food_order_app/screens/authendication/pages/signup_page.dart';
import 'package:food_order_app/screens/home/page/home_screen.dart';

void main() {
  runApp(const MyApp());
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
        home: const HomeScreen());
  }
}
