import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_4/Model/product_model.dart';

class CartController extends GetxController {
  final _storage = GetStorage();
  final cartItems = <ProductModel>[].obs;

  final _storageKey = 'cart_list';

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    final storedCart = _storage.read<List>(_storageKey);
    if (storedCart != null) {
      cartItems.assignAll(
        storedCart
            .map((e) => ProductModel.fromMap(Map<String, dynamic>.from(e)))
            .toList(),
      );
    }
  }

  void toggleCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      cartItems.removeAt(index);
    } else {
      cartItems.insert(0, product);
    }
    saveCart();
  }

  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index == -1) {
      cartItems.add(product);
      saveCart();
    }
  }

  void removeFromCart(ProductModel product) {
  cartItems.removeWhere((item) => item.id == product.id);
  saveCart();
}


  void clearCart() {
    cartItems.clear();
    _storage.remove(_storageKey);
  }

  bool isInCart(ProductModel product) {
    return cartItems.any((item) => item.id == product.id);
  }

  void saveCart() {
    final data = cartItems.map((e) => e.toMap()).toList();
    _storage.write(_storageKey, data);
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

  double get actualTotal => cartItems.fold(
    0.0, (sum, item) => sum + (item.price * item.quantity));

double get totalDiscount => cartItems.fold(
    0.0,
    (sum, item) =>
        sum + ((item.price * item.discountPercentage / 100) * item.quantity));

double get totalPrice => actualTotal - totalDiscount;

int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);

}
