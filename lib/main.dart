import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_4/Controller/auth_controller.dart';
import 'package:task_4/Controller/cart_controller.dart';
import 'package:task_4/Controller/favorite_controller.dart';
import 'package:task_4/Screen/Auth%20Page/home_page.dart';
import 'package:task_4/Screen/Home%20Screen/home_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // ✅ Register the FavoriteController
  Get.put(FavoriteController());
  Get.put(CartController());
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}