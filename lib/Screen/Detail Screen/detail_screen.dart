import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_4/Const/build_budget_button.dart';
import 'package:task_4/Const/color_class.dart';
import 'package:task_4/Controller/cart_controller.dart';
import 'package:task_4/Controller/favorite_controller.dart';
import 'package:task_4/Model/product_model.dart';
import 'package:task_4/Screen/Detail%20Screen/Widget/detail_image_slider.dart';
import 'package:task_4/Screen/Detail%20Screen/Widget/item_details.dart';

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
        backgroundColor: appbarBgColor,
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
                Divider(),
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
