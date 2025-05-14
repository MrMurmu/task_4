import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:task_4/Controller/cart_controller.dart';
import 'package:task_4/Controller/favorite_controller.dart';
import 'package:task_4/Model/product_model.dart';
import 'package:task_4/Screen/Cart%20Screen/cart_screen.dart';
import 'package:task_4/Screen/Detail%20Screen/Widget/app_bar.dart';
import 'package:task_4/Screen/Detail%20Screen/Widget/detail_image_slider.dart';
import 'package:task_4/Screen/Detail%20Screen/Widget/item_details.dart';
import 'package:task_4/Screen/Favorite%20Screen/favorite_screen.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final favController = Get.put(FavoriteController());
  final cartController = Get.put(CartController());
  int currentImage = 0;

  // Favorite icon with badge
  Widget buildFavIcon() {
    return Obx(() {
      final favCount = favController.favoriteProduct.length;
      return Stack(
        children: [
          IconButton(
            onPressed: () => Get.to(FavoriteScreen()),
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

  // Cart icon with badge
  Widget buildCartIcon() {
    return Obx(() {
      final cartCount = cartController.cartItems.length;
      return Stack(
        children: [
          IconButton(
            onPressed: () => Get.to(CartScreen()),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Detail",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        actions: [buildFavIcon(), buildCartIcon()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // DetailAppBar(product: widget.product),
                DetailImgSlider(
                  onChange: (value) {
                    setState(() {
                      currentImage = value;
                    });
                  },
                  image: widget.product.images.first,
                  product: widget.product,
                ),
                SizedBox(height: 10),
                ItemDetails(product: widget.product),
                SizedBox(height: 10),
                descripTion(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget descripTion() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              widget.product.description,
              maxLines: 4,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
