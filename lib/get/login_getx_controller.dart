import 'package:flutter/material.dart';
import 'package:flutter_app/main_menu_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../bottom_navigation_page.dart';

class LoginGetxController extends GetxController {
  final box = GetStorage();
  // RxString myName = "".obs;
  final formKey = GlobalKey<FormState>();
  RxBool statusObsecure = true.obs;

  TextEditingController nameField = TextEditingController();
  TextEditingController passwordField = TextEditingController();

  void actionHidePassword() {
    statusObsecure.value = !statusObsecure.value;
  }

  void actionSubmit() {
    if (formKey.currentState!.validate()) {
      box.write("name", nameField.text);
      Get.to(MainMenuPage());
    } else {
      Get.snackbar("Data Kosong", "Periksa Data",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
