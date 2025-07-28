import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../main_menu_page.dart';
import 'login_controller_bloc.dart';
import 'login_entity.dart';

class LoginPageBloc extends StatefulWidget {
  const LoginPageBloc({super.key});

  @override
  State<LoginPageBloc> createState() => _LoginPageBlocState();
}

class _LoginPageBlocState extends State<LoginPageBloc> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<LoginControllerBloc, LoginEntity>(
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login Page (GET)"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: state.nameField,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      controller: state.passwordField,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Kolom ini wajib diisi";
                        }
                        return null;
                      },
                      obscureText: state.statusObsecure,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 20),
                          hintText: 'Masukan Password Anda',
                          suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<LoginControllerBloc>()
                                    .actionHidePassword();
                              },
                              icon: Icon(state.statusObsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var box = GetStorage();
                        if (formKey.currentState!.validate()) {
                          box.write("name", state.nameField.text);
                          Get.to(MainMenuPage());
                        } else {
                          Get.snackbar("Data Kosong", "Periksa Data",
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
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
            );
          },
        ),
      ),
    );
  }
}
