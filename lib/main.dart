import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_app/controllers/bindings/authbinding.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/login.dart';
import 'Utils/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// final _key = GlobalKey();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      home: Root(),
      initialRoute: '/',
      theme: ThemeData.dark(),
    );
  }
}
