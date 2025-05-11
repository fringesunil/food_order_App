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
          children: [
            // Search Bar
            Padding(
              padding:
                  EdgeInsets.only(top: size.height * 0.01, left: 16, right: 16),
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
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
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: const Icon(Icons.search, color: Colors.amber),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: filteredHotels == null || filteredHotels.isEmpty
                    ? const Center(child: Text("No hotels found"))
                    : ListView.builder(
                        itemCount: filteredHotels.length,
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
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      '${filteredHotels[index].image}',
                                      width: size.width * 0.3,
                                      height: size.width * 0.3,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${filteredHotels[index].name}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            _buildStatIcon(
                                                Icons.access_time, "30 min"),
                                            SizedBox(width: 16),
                                            _buildStatIcon(Icons.star, "4.5"),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.favorite_border,
                                                  color: Colors.grey),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.share,
                                                  color: Colors.grey),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ],
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

  Widget _buildStatIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        SizedBox(width: 4),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
