
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_4/Screen/Auth%20Page/login_page.dart';
import 'package:task_4/Screen/Home%20Screen/home_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    bool isLoggedIn = box.read('isLoggedIn') ?? false;

    
    // Navigate to the appropriate page based on login state
    return isLoggedIn ? HomeScreen() : LoginPage();
  }
}