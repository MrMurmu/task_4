import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
  int currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Detail",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),),
          backgroundColor: Colors.blue.shade700,
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              Get.to(FavoriteScreen());
            }, icon: Icon(Icons.favorite, color: Colors.white,)),
            IconButton(onPressed: (){
              Get.to(CartScreen());
            }, icon: Icon(Icons.shopping_cart_checkout_outlined, color: Colors.white,))
          ],
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
