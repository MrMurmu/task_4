import 'dart:convert';

import 'package:get/get.dart';
import 'package:task_4/Model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  var productList = <ProductModel>[].obs;

  Future<void> getProduct() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['products'] as List;
        productList.value = data.map((e) => ProductModel.fromMap(e)).toList();
        // productList.shuffle();
        // printProductCategories();
      } else {
        throw Exception("Failed to load product");
      }
    } catch (e) {
      print('error occured $e');
    }
  }

  // void printProductCategories() {
  //   final categories = productList.map((product) => product.category).toSet();
  //   for (var category in categories) {
  //     print(category);
  //   }
  // }
}
