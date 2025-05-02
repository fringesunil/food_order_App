import 'package:flutter/material.dart';
import 'package:food_order_app/core/common/colors.dart';
import 'package:food_order_app/screens/cart/pages/cart_screen.dart';
import 'package:food_order_app/screens/home/provider/home_provider.dart';
import 'package:food_order_app/screens/home/widgets/hotel_list_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var homepro = Provider.of<HomeProvider>(context, listen: false);
    homepro.fetchhotels(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/bg.png'),
            radius: 20,
          ),
        ),
        title: Text(
          'Hi, username',
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
        actions: [],
      ),
      body: _selectedIndex == 0 ? HotelListScreen() : CartScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black.withOpacity(0.7),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
