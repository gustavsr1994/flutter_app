import 'package:flutter/material.dart';
import 'package:flutter_app/data/repository/auth_repository.dart';
import 'package:flutter_app/product/view/main_product_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../bottom_navigation_page.dart';

class LoginControllerProvider extends ChangeNotifier {
  AuthRepository _authRepository = AuthRepository();

  final formKey = GlobalKey<FormState>();
  bool statusObsecure = true;

  TextEditingController nameField = TextEditingController();
  TextEditingController emailField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  TextEditingController passwordConfirmationField = TextEditingController();

  void actionHidePassword() {
    statusObsecure = !statusObsecure;
    notifyListeners();
  }

  void actionSubmitRegister() async {
    if (formKey.currentState!.validate()) {
      var request = {
        "name": nameField.text,
        "email": emailField.text,
        "password": passwordField.text,
        "password_confirmation": passwordConfirmationField.text
      };
      try {
        var result = await _authRepository.registerFunction(request);

        Get.snackbar("Success", "Message: ${result.user!.email}",
            backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        Get.snackbar("Error", "Message: ${e.toString()}",
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar("Data Kosong", "Periksa Data",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void actionSubmitLogin() async {
    final box = GetStorage();
    if (formKey.currentState!.validate()) {
      var request = {
        "email": emailField.text,
        "password": passwordField.text
      };
      try {
        var result = await _authRepository.loginFunction(request);
        box.write("token", result.token);
        Get.to(MainProductPage());
      } catch (e) {
        Get.snackbar("Error", "Message: ${e.toString()}",
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar("Data Kosong", "Periksa Data",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
