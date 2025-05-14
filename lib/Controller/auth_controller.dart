import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/auth_model.dart';

class AuthController extends GetxController {
  final box = GetStorage();

  void signup(String userName, String email, String password) {
    final user = AuthModel(userName: userName, email: email, password: password);
    box.write('user', user.toMap());
  }

  AuthModel? getUser() {
    final data = box.read('user');
    if (data != null) {
      return AuthModel.fromMap(Map<String, dynamic>.from(data));
    }
    return null;
  }

  bool login(String userName, String password) {
    final user = getUser();
    if (user != null && user.userName == userName && user.password == password) {
      box.write('isLoggedIn', true);
      return true;
    }
    return false;
  }

  void logout() {
    box.write('isLoggedIn', false);
  }
}
