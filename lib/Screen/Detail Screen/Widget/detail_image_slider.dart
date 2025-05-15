import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_4/Controller/favorite_controller.dart';
import 'package:task_4/Model/product_model.dart';
import 'package:task_4/Const/quantity_controller.dart';

class DetailImgSlider extends StatelessWidget {
  final ProductModel product;
  final Function(int) onChange;
  final String image;
  const DetailImgSlider({
    super.key,
    required this.onChange,
    required this.image,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final favController = Get.put(FavoriteController());
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: SizedBox(
            height: 250,
            child: PageView.builder(
              onPageChanged: onChange,
              itemBuilder: (context, index) {
                return Hero(tag: image, child: Image.network(image, loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null)
                  return child;
                  return Shimmer.fromColors(child: Container(height: 250, color: Colors.white,), baseColor: Colors.grey.shade300, highlightColor: Colors.grey.shade100);
                },));
              },
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 0,
          child: Obx(
            () => IconButton(
              onPressed: () => favController.toggleFavorite(product),
              icon: Icon(
                favController.isFavorite(product)
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: Colors.red,
              ),
            ),
          ),
        ),
        Positioned(
          top: 190,
          right: 0,
          child: QuantityControl(product: product),
        ),
      ],
    );
  }
}
