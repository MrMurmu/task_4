import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_4/Controller/api_controller.dart';
import '../Model/auth_model.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  final storage = GetStorage();

  var currentUser = Rxn<AuthModel>();

  @override
  void onInit() {
    final userMap = storage.read('currentUser');
    if (userMap != null) {
      currentUser.value = AuthModel.fromMap(Map<String, dynamic>.from(userMap));
      isLoggedIn.value = true;
    }
    super.onInit();
  }

  // Login from list of users
  bool login(String userName, String password) {
    final userList = storage.read('registeredUsers') ?? [];
    final users = List<Map<String, dynamic>>.from(userList);

    final matchingUser = users.firstWhereOrNull((user) {
      final auth = AuthModel.fromMap(user);
      return auth.userName == userName && auth.password == password;
    });

    if (matchingUser != null) {
      final loggedInUser = AuthModel.fromMap(matchingUser);
      currentUser.value = loggedInUser;
      storage.write('currentUser', loggedInUser.toMap());
      isLoggedIn.value = true;
      storage.write('isLoggedIn', true);
      return true;
    } else {
      print('Invalid username or password');
      return false;
    }
  }

  // Register new user
  bool signup(String userName, String email, String password) {
    final userList = storage.read('registeredUsers') ?? [];
    final users = List<Map<String, dynamic>>.from(userList);

    final exists = users.any((user) {
      final auth = AuthModel.fromMap(user);
      return auth.userName == userName;
    });

    if (exists) {
      print('Username already exists');
      return false;
    }

    final newUser = AuthModel(
      userName: userName,
      email: email,
      password: password,
    );
    users.add(newUser.toMap());

    storage.write('registeredUsers', users);
    // storage.write('currentUser', newUser.toMap());
    // currentUser.value = newUser;
    // isLoggedIn.value = true;
    return true;
  }

  // Logout
  void logout() {
    storage.remove('currentUser');
    isLoggedIn.value = false;
    currentUser.value = null;
    storage.write('isLoggedIn', false);

    final apiController = Get.find<ApiController>();
    apiController.productList.clear();
    apiController.getProduct();
  }
}
