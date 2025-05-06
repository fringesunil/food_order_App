import 'package:flutter/material.dart';
import 'package:food_order_app/screens/menu/provider/menu_provider.dart';
import 'package:provider/provider.dart';

class MenuListScreen extends StatefulWidget {
  String? hotelId;
  MenuListScreen({super.key, this.hotelId});

  @override
  State<MenuListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  @override
  void initState() {
    var menupro = Provider.of<MenuProvider>(context, listen: false);
    menupro.fetchMenu(context, widget.hotelId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        elevation: 0,
        title: const Text(
          'Menu',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("Navigate to cart");
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Consumer<MenuProvider>(builder: (context, menu, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: menu.menulist!.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Menu Item Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "${menu.menulist![index].image}",
                        width: size.width * 0.25,
                        height: size.width * 0.25,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: size.width * 0.25,
                          height: size.width * 0.25,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    // Menu Item Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${menu.menulist![index].name}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\u20B9 ${(menu.menulist![index].price)!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Quantity Toggle
                          Row(
                            children: [
                              IconButton(
                                onPressed: menu.qty[index] > 0
                                    ? () {
                                        menu.decrementQuantity(index);
                                      }
                                    : null,
                                icon: const Icon(Icons.remove_circle_outline),
                                color: Colors.amber,
                              ),
                              Text(
                                '${menu.qty[index]}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    menu.incrementQuantity(index);
                                  });
                                },
                                icon: const Icon(Icons.add_circle_outline),
                                color: Colors.amber,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Add to Cart Button
                    ElevatedButton(
                      onPressed: menu.qty[index] > 0
                          ? () {
                              print(
                                  "TOTAL QTY=======>${menu.menulist![index].id}");
                              print("TOTAL QTY=======>${menu.qty[index]}");
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
