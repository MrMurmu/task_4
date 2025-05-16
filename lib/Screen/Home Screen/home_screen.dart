import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_4/Const/build_budget_button.dart';
import 'package:task_4/Controller/api_controller.dart';
import 'package:task_4/Controller/auth_controller.dart';
import 'package:task_4/Controller/favorite_controller.dart';
import 'package:task_4/Screen/Auth%20Page/home_page.dart';
import 'package:task_4/Const/quantity_controller.dart';
import 'package:task_4/Const/product_card.dart';
import 'package:task_4/Const/color_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final apiController = Get.put(ApiController());
  final favController = Get.put(FavoriteController());
  final authController = Get.put(AuthController());
  // final buildButton = BuildBudgetButton();

  @override
  void initState() {
    super.initState();
    apiController.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appbarBgColor,
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
                  // return const Center(child: CircularProgressIndicator());
                  return _shimmerLoading();
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
                              onPressed: () {
                                if (authController.isLoggedIn.value) {
                                  favController.toggleFavorite(product);
                                } else {
                                  Get.snackbar(
                                    'Login Required',
                                    'Please login to add favorites.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.redAccent,
                                    colorText: Colors.white,
                                    duration: Duration(seconds: 2),
                                  );
                                }
                              },
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

  // Loading effect

  Widget _shimmerLoading() {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.58,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
          ),
        );
      },
    );
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
}
