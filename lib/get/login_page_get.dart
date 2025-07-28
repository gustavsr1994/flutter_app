import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/get/login_getx_controller.dart';
import 'package:flutter_app/main_menu_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginPageGet extends StatefulWidget {
  const LoginPageGet({super.key});

  @override
  State<LoginPageGet> createState() => _LoginPageGetState();
}

class _LoginPageGetState extends State<LoginPageGet> {
  final LoginGetxController controller = Get.put(LoginGetxController());
  final box = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 1),
      () {
        if (box.read("name") != null) {
          Get.to(MainMenuPage());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login Page (GET)"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: controller.nameField,
                    decoration: InputDecoration(
                        labelText: 'Nama',
                        labelStyle: TextStyle(fontSize: 20),
                        hintText: 'Masukan Nama Anda',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: controller.passwordField,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Kolom ini wajib diisi";
                      }
                      return null;
                    },
                    obscureText: controller.statusObsecure.value,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 20),
                        hintText: 'Masukan Password Anda',
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.actionHidePassword();
                            },
                            icon: Icon(controller.statusObsecure.value
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => controller.actionSubmit(),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      "Elevated Button",
                      style: TextStyle(color: Colors.yellow),
                    )),
                OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.green, width: 3)),
                    child: Text("Outlined Button")),
                TextButton(onPressed: () {}, child: Text("Text Button")),
                IconButton(onPressed: () {}, icon: Icon(Icons.camera))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
