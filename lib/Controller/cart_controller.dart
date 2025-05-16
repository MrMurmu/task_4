import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_4/Controller/auth_controller.dart';
import 'package:task_4/Model/product_model.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs;

  final storage = GetStorage();
  final authController = Get.find<AuthController>();

  String get _userKey => authController.currentUser.value?.userName ?? '';

  @override
  void onInit() {
    ever(authController.currentUser, (_) => loadStorage());
    loadStorage();
    super.onInit();
  }

  void addToCart(ProductModel p) {
    cartItems.add(p);
    saveStorage();
  }

  void removeFromCart(ProductModel p) {
    cartItems.remove(p);
    saveStorage();
  }

  void saveStorage() {
    if (_userKey.isNotEmpty) {
      storage.write(
        '${_userKey}_cart',
        cartItems.map((e) => e.toMap()).toList(),
      );
    }
  }

  void loadStorage() {
    if (_userKey.isNotEmpty) {
      final cartData = storage.read('${_userKey}_cart') ?? [];
      cartItems.value =
          cartData.map<ProductModel>((e) => ProductModel.fromMap(e)).toList();
    } else {
      cartItems.clear();
    }
  }

  void toggleCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      cartItems.removeAt(index);
    } else {
      cartItems.insert(0, product);
    }
    saveStorage();
  }

  bool isInCart(ProductModel product) {
    return cartItems.any((item) => item.id == product.id);
  }

  void incrementQuantity(ProductModel product) {
    final index = cartItems.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    }
  }

  void decrementQuantity(ProductModel product) {
    final index = cartItems.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        cartItems.removeAt(index);
      }
      cartItems.refresh();
    }
  }

  double get actualTotal =>
      cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  double get totalDiscount => cartItems.fold(
    0.0,
    (sum, item) =>
        sum + ((item.price * item.discountPercentage / 100) * item.quantity),
  );

  double get totalPrice => actualTotal - totalDiscount;

  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);
}
