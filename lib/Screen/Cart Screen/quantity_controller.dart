import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:task_4/Controller/cart_controller.dart';
import 'package:task_4/Model/product_model.dart';

class QuantityControl extends StatelessWidget {
  final ProductModel product;

  QuantityControl({required this.product});

  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    
    return Obx(() {
      if (!cartController.isInCart(product)) {
        return IconButton(
          onPressed: () => cartController.toggleCart(product),
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.blue),
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              child: Obx(() {
                if (!cartController.isInCart(product)) return const SizedBox();
                final cartProduct = cartController.cartItems.firstWhere(
                  (p) => p.id == product.id,
                  orElse: () => product,
                );
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 20,
                          onPressed:
                              () => cartController.decrementQuantity(product),
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          '${cartProduct.quantity}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 20,
                          onPressed:
                              () => cartController.incrementQuantity(product),
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
    });
  }
}
