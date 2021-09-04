import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Screens/home.dart';
import 'package:todo_app/Screens/login.dart';
import 'package:todo_app/controllers/authcontroller.dart';
import 'package:todo_app/controllers/userController.dart';

class Root extends GetWidget<AuthController> {
  void printf() {
    print("I am here");
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user?.uid != null) {
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}
