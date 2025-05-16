import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_4/Controller/auth_controller.dart';
import 'package:task_4/Model/product_model.dart';

class FavoriteController extends GetxController {
  var favorites = <ProductModel>[].obs;

  final storage = GetStorage();
  final authController = Get.find<AuthController>();

  String get _userKey => authController.currentUser.value?.userName ?? '';

  @override
  void onInit() {
    ever(authController.currentUser, (_) => loadStorage());
    loadStorage();
    super.onInit();
  }


  void toggleFavorite(ProductModel p) {

  if (isFavorite(p)) {
    favorites.removeWhere((item) => item.id == p.id);
  } else {
    favorites.add(p);
  }
  saveStorage();
}

  bool isFavorite(ProductModel p) {
  return favorites.any((item) => item.id == p.id);
}

  void saveStorage() {
    if (_userKey.isNotEmpty) {
      storage.write('${_userKey}_favorites', favorites.map((e) => e.toMap()).toList());
    }
  }

  void loadStorage() {
    if (_userKey.isNotEmpty) {
      final favData = storage.read('${_userKey}_favorites') ?? [];
      favorites.value = favData.map<ProductModel>((e) => ProductModel.fromMap(e)).toList();
    } else {
      favorites.clear();
    }
  }
}
