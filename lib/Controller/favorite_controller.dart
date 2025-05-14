import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/product_model.dart';

class FavoriteController extends GetxController {
  final _storage = GetStorage();
  final favoriteProduct = <ProductModel>[].obs;

  final _storageKey = 'favorite_list';

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    final storedFavorites = _storage.read<List>(_storageKey);
    if (storedFavorites != null) {
      favoriteProduct.assignAll(
        storedFavorites.map(
          (e) => ProductModel.fromMap(Map<String, dynamic>.from(e)),
        ),
      );
    }
  }

  // void toggleFavorite(ProductModel product) {
  //   final index = favoriteProduct.indexWhere((item) => item.id == product.id);
  //   if (index >= 0) {
  //     favoriteProduct.removeAt(index);
  //   } else {
  //     favoriteProduct.add(product);
  //   }
  //   saveFavorite();
  // }

  void toggleFavorite(ProductModel product) {
    final index = favoriteProduct.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      favoriteProduct.removeAt(index);
    } else {
      favoriteProduct.insert(0, product);
    }
    saveFavorite();
  }

  bool isFavorite(ProductModel product) {
    return favoriteProduct.any((item) => item.id == product.id);
  }

  void saveFavorite() {
    final data = favoriteProduct.map((e) => e.toMap()).toList();
    _storage.write(_storageKey, data);
  }

  void removeFavorite(ProductModel product) {
    final index = favoriteProduct.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      favoriteProduct.removeAt(index);
      saveFavorite();
    }
  }
}
