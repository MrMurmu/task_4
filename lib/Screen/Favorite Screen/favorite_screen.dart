import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:task_4/Const/color_class.dart';
import 'package:task_4/Controller/api_controller.dart';
import 'package:task_4/Controller/cart_controller.dart';
import 'package:task_4/Controller/favorite_controller.dart';
import 'package:task_4/Const/product_card.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final FavoriteController favController = Get.find();
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    final apiController = Get.put(ApiController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: appbarBgColor,
        title: const Text(
          "Favorite Products",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Expanded(
              child: Obx(() {
                if (favController.favorites.isEmpty) {
                  return const Center(child: Text("No favorite added here",style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),));
                } else {
                  return MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  
                  itemCount: favController.favorites.length,
                  itemBuilder: (context, index) {
                      final product = favController.favorites[index];

                      return Stack(
                        children: [
                          // product card
                          ProductCard(product: product),

                          // delete icon for delete from product

                          Positioned(
                            top: 5,
                            right: 0,
                            child: Obx(
                              () => IconButton(
                                onPressed:
                                    () => favController.toggleFavorite(product),
                                icon: Icon(
                                  favController.isFavorite(product)
                                      ? Icons.delete
                                      : Icons.favorite_border_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),

                          // Cart Toggle Icon
                          Positioned(
                            top: 110,
                            right: 0,
                            child: Obx(() {
                              if (!cartController.isInCart(product)) {
                                return IconButton(
                                  onPressed:
                                      () => cartController.toggleCart(product),
                                  icon: const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.blue,
                                  ),
                                );
                              } else {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      child: Obx(() {
                                        if (!cartController.isInCart(product))
                                          return const SizedBox();
                                        final cartProduct = cartController
                                            .cartItems
                                            .firstWhere(
                                              (p) => p.id == product.id,
                                              orElse: () => product,
                                            );
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 25,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              // border: Border.all(
                                              //   width: 1,
                                              //   color: Colors.black
                                              // )
                                            ),
                                            margin: EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  iconSize: 20,
                                                  onPressed:
                                                      () => cartController
                                                          .decrementQuantity(
                                                            product,
                                                          ),
                                                  icon: const Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  '${cartProduct.quantity}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  iconSize: 20,
                                                  onPressed:
                                                      () => cartController
                                                          .incrementQuantity(
                                                            product,
                                                          ),
                                                  icon: const Icon(
                                                    Icons.add_circle_outline,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                );
                              }
                            }),
                          ),
                          // ------------------------------------
                    //       Positioned(
                    //  top: 110,
                    //         right: 0,
                    //   child: QuantityControl(product: product),
                    // ),
                        ],
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
