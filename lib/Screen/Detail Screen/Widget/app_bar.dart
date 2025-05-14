import 'package:flutter/material.dart';
import 'package:task_4/Model/product_model.dart';
import 'package:task_4/Screen/Cart%20Screen/cart_screen.dart';


class DetailAppBar extends StatelessWidget {
  final ProductModel product;

  const DetailAppBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Row(
            children: [
              
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
                icon: Icon(Icons.shopping_cart_checkout_sharp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
