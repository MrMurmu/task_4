import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
import 'package:task_4/Controller/api_controller.dart';
import 'package:task_4/Controller/auth_controller.dart';
import 'package:task_4/Controller/cart_controller.dart';
import 'package:task_4/Controller/favorite_controller.dart';
import 'package:task_4/Screen/Auth%20Page/home_page.dart';
import 'package:task_4/Screen/Auth%20Page/login_page.dart';
import 'package:task_4/Screen/Cart%20Screen/cart_screen.dart';
import 'package:task_4/Screen/Cart%20Screen/quantity_controller.dart';
import 'package:task_4/Screen/Favorite%20Screen/favorite_screen.dart';
import 'package:task_4/Screen/Home%20Screen/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final apiController = Get.put(ApiController());
  final favController = Get.put(FavoriteController());
  final cartController = Get.put(CartController());
  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    apiController.getProduct();
  }

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
            icon: const Icon(Icons.shopping_cart_checkout_outlined, color: Colors.white),
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

  // Login/Logout icon widget
  final storage = GetStorage(); 

  Widget buildAuthIcon() {
  final isLoggedIn = storage.read('isLoggedIn') ?? false;

  return IconButton(
    onPressed: () {
      if (isLoggedIn) {
        authController.logout();
        Get.offAll(() => HomeScreen());
      } else {
        Get.offAll(() => HomePage());
      }
    },
    icon: Icon(isLoggedIn ? Icons.logout : Icons.login, color: Colors.white),
  );
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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.shade700,
      automaticallyImplyLeading: false,
        title: const Text(
          "Product List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [buildAuthIcon(), buildFavIcon(), buildCartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (apiController.productList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.58,
                  ),
                  itemCount: apiController.productList.length,
                  itemBuilder: (context, index) {
                    final product = apiController.productList[index];
                    return Stack(
                      children: [
                        ProductCard(product: product),

                        // favorite
                        Positioned(
                          top: 5,
                          right: 0,
                          child: Obx(
                            () => IconButton(
                              onPressed:
                                  () => favController.toggleFavorite(product),
                              icon: Icon(
                                favController.isFavorite(product)
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        // cart
                        Positioned(
                          top: 110,
                          right: 0,
                          child: QuantityControl(product: product),
                        ),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
