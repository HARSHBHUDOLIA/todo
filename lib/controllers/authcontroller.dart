import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/Services/database.dart';
import 'package:todo_app/controllers/userController.dart';
import 'package:todo_app/models/user.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUser(String name, String email, String password) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      UserModel user = UserModel(
        id: _authResult.user!.uid,
        name: name,
        email: email.trim(),
      );
      if (await Database().createNewUser(user)) {
        Get.find<UserController>().user = user;
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating user',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.find<UserController>().user =
          await Database().getUser(_authResult.user!.uid);
    } catch (e) {
      Get.snackbar(
        'Error Logging user',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
    } catch (e) {
      Get.snackbar(
        'Error Signing Out user',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
