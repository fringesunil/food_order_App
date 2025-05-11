import 'package:flutter/material.dart';
import 'package:food_order_app/core/common/common_methods.dart';
import 'package:food_order_app/screens/cart/provider/cart_provider.dart';
import 'package:food_order_app/screens/order/provider/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with CommonMethods {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    var cartpro = Provider.of<CartProvider>(context, listen: false);
    cartpro.fetchcart(context);

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    var cartpro = Provider.of<CartProvider>(context, listen: false);
    var orderpro = Provider.of<OrderProvider>(context, listen: false);

    if (response.paymentId!.isNotEmpty) {
      print(
          "Total Amount==============>${cartpro.cartlist!.first.totalAmount}");
      print("GST Amount==============>${cartpro.cartlist!.first.gstAmount}");
      print("DIS Amount==============>${cartpro.cartlist!.first.discount}");
      cartpro.cartlist!.first.cartItems!.forEach((e) {
        print("CART ITEMS-Name============>${e.menuId!.name}");
        print("CART ITEMS-ID============>${e.menuId!.id}");
        print("CART ITEMS-QTY============>${e.quantity}");
        cartpro.cartItemsList.add({
          "menu_id": e.menuId!.id,
          "quantity": e.quantity,
        });
        orderpro.addOrder(
            context,
            cartpro.cartlist!.first.totalAmount!,
            cartpro.cartlist!.first.discount!,
            cartpro.cartlist!.first.gstAmount!,
            cartpro.cartItemsList,
            cartpro.cartlist!.first.id!);
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Successful: ${response.paymentId}")),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External Wallet: ${response.walletName}")),
    );
  }

  void _openCheckout(double amount) {
    var options = {
      'key': 'rzp_test_eKhFJmDgLky7dl',
      'amount': (amount * 100).toInt(),
      'name': 'Fringe Creations',
      'description': 'Payment for cart items',
      'prefill': {
        'contact': '1234567890',
        'email': 'user@example.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<CartProvider>(builder: (context, cart, child) {
        return cart.cartlist!.isEmpty
            ? const Center(
                child: Text("No data found"),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: cart.cartlist!.first.cartItems!.length,
                      itemBuilder: (context, index) {
                        return _buildCartItem(
                          size,
                          cart.cartlist![0].cartItems![index].menuId!.name!,
                          cart.cartlist![0].cartItems![index].menuId!.price!
                              .toDouble(),
                          cart.cartlist![0].cartItems![index].menuId!.image!,
                          cart.cartlist![0].cartItems![index].quantity!,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bill Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildBillRow('Subtotal',
                            cart.cartlist![0].totalAmount!.toDouble()),
                        _buildBillRow(
                            'GST ', cart.cartlist![0].gstAmount!.toDouble()),
                        const Divider(height: 20),
                        _buildBillRow(
                            'Total',
                            (cart.cartlist![0].totalAmount!.toDouble() +
                                cart.cartlist![0].gstAmount!.toDouble()),
                            isTotal: true),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final totalAmount =
                                  cart.cartlist![0].totalAmount!.toDouble() +
                                      cart.cartlist![0].gstAmount!.toDouble();
                              _openCheckout(totalAmount);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Proceed to Checkout',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
      }),
    );
  }

  Widget _buildCartItem(
      Size size, String name, double price, String imageUrl, int quantity) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: size.width * 0.2,
                height: size.width * 0.2,
                color: Colors.grey[300],
                child: Image.network(imageUrl),
              ),
            ),
            const SizedBox(width: 12),
            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\u20B9 ${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Quantity Controls
                  Row(
                    children: [
                      const Icon(Icons.remove_circle_outline,
                          color: Colors.amber),
                      const SizedBox(width: 10),
                      Text(
                        '$quantity',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.add_circle_outline, color: Colors.amber),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey[700],
            ),
          ),
          Text(
            '\u20B9 ${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
