import 'package:flutter/material.dart';
import 'package:food_order_app/core/common/colors.dart';

class MenuListScreen extends StatefulWidget {
  const MenuListScreen({super.key});

  @override
  State<MenuListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
 
  @override
  void initState() {
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
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: 3,
        itemBuilder: (context, index) {
          // final menuItem = widget.menuItems[index];
          var quantity = 0;

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
                      "https://res.cloudinary.com/drinn62yk/image/upload/v1733656730/cgzx7abn2biw06cdcr25.jpg",
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
                          "Name",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '\$${(100).toStringAsFixed(2)}',
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
                              onPressed: quantity > 0
                                  ? () {
                                      setState(() {
                                        // itemQuantities[menuItem.id] =
                                        //     quantity - 1;
                                        quantity = quantity - 1;
                                      });
                                    }
                                  : null,
                              icon: const Icon(Icons.remove_circle_outline),
                              color: Colors.amber,
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  print("pressed======>");
                                  // itemQuantities[menuItem.id] = quantity + 1;
                                  quantity = quantity + 1;
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
                    onPressed: quantity > 0
                        ? () {
                            // Add to cart logic (placeholder)
                            // print(
                            //     "Added ${menuItem.name} (Qty: $quantity) to cart");
                            // // Reset quantity after adding to cart
                            // setState(() {
                            //   itemQuantities[menuItem.id] = 0;
                            // });
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
      ),
    );
  }
}
