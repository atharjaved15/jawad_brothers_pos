import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jawad_brothers_pos/routes.dart';

class AuthController extends GetxController {
  static AuthController instance =
      Get.find(); // Access to the controller instance

  FirebaseAuth auth = FirebaseAuth.instance; // FirebaseAuth instance

  // Registration method
  Future<void> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar(
        "Success",
        "Account created successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error Creating Account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Login method
  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        "Success",
        "Logged in successfully",
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        //maxWidth: 500,
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed(AppRoutes.dashboard);
    } catch (e) {
      Get.snackbar(
        "Error Logging In",
        e.toString(),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        //maxWidth: 500,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Logout method
  Future<void> logOut() async {
    try {
      await auth.signOut();
      Get.snackbar(
        "Success",
        "Logged out successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error Logging Out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
