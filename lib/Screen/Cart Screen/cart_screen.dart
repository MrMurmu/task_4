import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_4/Const/color_class.dart';
import 'package:task_4/Controller/cart_controller.dart';
import 'package:task_4/Const/quantity_controller.dart';
import 'package:task_4/Const/product_card.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appbarBgColor,
        title: const Text(
          "My Cart",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          if (cartController.cartItems.isEmpty) {
            return const Center(child: Text("Your cart is empty",style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),));
          } else {
            return GridView.builder(
              itemCount: cartController.cartItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.58,
              ),
              itemBuilder: (context, index) {
                final product = cartController.cartItems[index];
                return Stack(
                  children: [
                    ProductCard(product: product),
                    Positioned(
                      top: 5,
                      right: 0,
                      child: IconButton(
                        onPressed: () => cartController.toggleCart(product),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      right: 0,
                      child: QuantityControl(product: product),
                    ),
                  ],
                );
              },
            );
          }
        }),
      ),
      bottomNavigationBar: Obx(() {
        return cartController.cartItems.isEmpty
            ? const SizedBox.shrink()
            : bottomAppbar();
      }),
    );
  }

  Widget bottomAppbar() {
    return BottomAppBar(
      height: 300,
      child: Column(
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Price Detail",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price (${cartController.totalItems} items)",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text("Discount", style: TextStyle(fontSize: 16)),
                          SizedBox(height: 5),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            cartController.actualTotal.toStringAsFixed(2),
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "-${cartController.totalDiscount.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cartController.totalPrice.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue.shade700,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Price: ₹${cartController.totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (cartController.cartItems.isEmpty) {
                      Get.snackbar("Cart Empty", "Add items before checkout");
                    } else {
                      // Navigate to payment/checkout
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: const Center(
                      child: Text(
                        "Buy Now",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
