import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_4/Controller/auth_controller.dart';
import 'package:task_4/Controller/cart_controller.dart';
import 'package:task_4/Controller/favorite_controller.dart';
import 'package:task_4/Screen/Cart%20Screen/cart_screen.dart';
import 'package:task_4/Screen/Favorite%20Screen/favorite_screen.dart';

final authController = Get.find<AuthController>();
final favController = Get.find<FavoriteController>();
final cartController = Get.find<CartController>();

Widget buildFavIcon() {
  return Obx(() {
    final favCount = favController.favorites.length;
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            // if (authController.isLoggedIn.value) {
              Get.to(() => FavoriteScreen());
            // } else {
            //   Get.snackbar(
            //     'Login Required',
            //     'Please login to view favorites.',
            //     snackPosition: SnackPosition.BOTTOM,
            //     backgroundColor: Colors.redAccent,
            //     colorText: Colors.white,
            //     duration: Duration(seconds: 2),
            //   );
            // }
          },
          icon: const Icon(Icons.favorite, color: Colors.white),
        ),
        if (favCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: _buildBadge(favCount, Colors.red),
          ),
      ],
    );
  });
}

Widget buildCartIcon() {
  return Obx(() {
    final cartCount = cartController.cartItems.length;
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            // if (authController.isLoggedIn.value) {
              Get.to(() => CartScreen());
            // } else {
            //   Get.snackbar(
            //     'Login Required',
            //     'Please login to view cart.',
            //     snackPosition: SnackPosition.BOTTOM,
            //     backgroundColor: Colors.redAccent,
            //     colorText: Colors.white,
            //     duration: Duration(seconds: 2),
            //   );
            // }
          },
          icon: const Icon(
            Icons.shopping_cart_checkout_outlined,
            color: Colors.white,
          ),
        ),
        if (cartCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: _buildBadge(cartCount, Colors.green),
          ),
      ],
    );
  });
}

// Common badge builder
Widget _buildBadge(int count, Color color) {
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
    child: Text(
      '$count',
      style: const TextStyle(color: Colors.white, fontSize: 10),
      textAlign: TextAlign.center,
    ),
  );
}
