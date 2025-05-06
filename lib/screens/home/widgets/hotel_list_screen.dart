import 'package:flutter/material.dart';
import 'package:food_order_app/core/common/common_methods.dart';
import 'package:food_order_app/core/routes/routes_string.dart';
import 'package:food_order_app/screens/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HotelListScreen extends StatefulWidget {
  const HotelListScreen({super.key});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> with CommonMethods {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<HomeProvider>(builder: (context, home, child) {
        final filteredHotels = home.searchQuery.isEmpty
            ? home.hotelList
            : home.hotelList
                ?.where((hotel) => hotel.name!
                    .toLowerCase()
                    .contains(home.searchQuery.toLowerCase()))
                .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.02),
              child: Container(
                height: size.height * 0.06,
                width: size.width * 0.90,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.amber),
                ),
                child: TextFormField(
                  controller: home.searchController,
                  onChanged: (value) {
                    setState(() {
                      home.searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search for Hotel",
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.search, color: Colors.amber),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: size.width * 0.03),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: filteredHotels == null || filteredHotels.isEmpty
                    ? const Center(child: Text("No hotels found"))
                    : GridView.builder(
                        itemCount: filteredHotels.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                print(
                                    "HOTEL ID===============>${filteredHotels[index].id}");
                                moveTowitharg(context, AppRoutes.menu,
                                    filteredHotels[index].id!);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(15),
                                      ),
                                      child: Image.network(
                                        '${filteredHotels[index].image}',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${filteredHotels[index].name}',
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
