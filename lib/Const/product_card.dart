import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_4/Controller/cart_controller.dart';
import 'package:task_4/Controller/favorite_controller.dart';
import 'package:task_4/Model/product_model.dart';
import 'package:task_4/Screen/Detail%20Screen/detail_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  ProductCard({super.key, required this.product});

  final FavoriteController favController = Get.find();
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(product: product)));
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
              border: Border.all(width: 1, color: Colors.black.withOpacity(0.1)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Hero(
                          tag: product.images,
                          child: Image.network(
                            product.images.first,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const SizedBox(
                                width: 120,
                                height: 120,
                                child: Center(
                                  child: Text(
                                    "Loading...",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text(
                            "Price :",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            "₹ ${product.price.toString()}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Stock ${product.stock.toString()}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Container(
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.green.shade200,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1, color: Colors.green),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star, size: 15, color: Colors.yellow),
                                const SizedBox(width: 2),
                                Text(
                                  product.rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '↓${product.discountPercentage.toString()}%',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.green
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
      
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     SizedBox(
                      //       child: Obx(() {
                      //         if (!cartController.isInCart(product)) return const SizedBox();
                      //         final cartProduct = cartController.cartItems.firstWhere(
                      //           (p) => p.id == product.id,
                      //           orElse: () => product,
                      //         );
                      //         return Container(
                      //           margin: EdgeInsets.only(left: 20),
                      //           child: Row(
                      //             children: [
                      //               IconButton(
                      //                 padding: EdgeInsets.zero,
                      //                 iconSize: 20,
                      //                 onPressed: () => cartController.decrementQuantity(product),
                      //                 icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                      //               ),
                      //               Text(
                      //                 '${cartProduct.quantity}',
                      //                 style: const TextStyle(fontWeight: FontWeight.bold),
                      //               ),
                      //               IconButton(
                      //                 padding: EdgeInsets.zero,
                      //                 iconSize: 20,
                      //                 onPressed: () => cartController.incrementQuantity(product),
                      //                 icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       }),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      
          // Favorite Icon (Top Right)
          // Positioned(
          //   top: 5,
          //   right: 0,
          //   child: Obx(() => IconButton(
          //         onPressed: () => favController.toggleFavorite(product),
          //         icon: Icon(
          //           favController.isFavorite(product)
          //               ? Icons.favorite
          //               : Icons.favorite_border_outlined,
          //           color: Colors.red,
          //         ),
          //       )),
          // ),
      
          // Positioned(
          //   top: 80,
          //   right: 0,
          //   child: Obx(() => IconButton(
          //         onPressed: () => cartController.toggleCart(product),
          //         icon: Icon(
          //           cartController.isInCart(product)
          //               ? Icons.remove_shopping_cart
          //               : Icons.shopping_cart_outlined,
          //           color: cartController.isInCart(product) ? Colors.red : Colors.blue,
          //         ),
          //       )),
          // ),
        ],
      ),
    );
  }
}