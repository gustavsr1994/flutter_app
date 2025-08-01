import 'package:flutter/material.dart';
import 'package:flutter_app/provider/login_controller_provider.dart';
import 'package:provider/provider.dart';

class LoginPageProvider extends StatefulWidget {
  const LoginPageProvider({super.key});

  @override
  State<LoginPageProvider> createState() => _LoginPageProviderState();
}

class _LoginPageProviderState extends State<LoginPageProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LoginControllerProvider>(
            builder: (context, controller, child) {
          return Form(
            key: controller.formKey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login Page (Provider)"),
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
                  child: TextField(
                    controller: controller.emailField,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 20),
                        hintText: 'Masukan Email Anda',
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
                    obscureText: controller.statusObsecure,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 20),
                        hintText: 'Masukan Password Anda',
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.actionHidePassword();
                            },
                            icon: Icon(controller.statusObsecure
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: controller.passwordConfirmationField,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Kolom ini wajib diisi";
                      }
                      return null;
                    },
                    obscureText: controller.statusObsecure,
                    decoration: InputDecoration(
                        labelText: 'Password Confirmation',
                        labelStyle: TextStyle(fontSize: 20),
                        hintText: 'Konfirmasi Password Anda',
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.actionHidePassword();
                            },
                            icon: Icon(controller.statusObsecure
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => controller.actionLoginFirebase(),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.yellow),
                    )),
                ElevatedButton(
                    onPressed: () => controller.actionRegisterFirebase(),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.yellow),
                    )),
                // ElevatedButton(
                //     onPressed: () => controller.actionSubmit(),
                //     style:
                //         ElevatedButton.styleFrom(backgroundColor: Colors.green),
                //     child: Text(
                //       "Elevated Button",
                //       style: TextStyle(color: Colors.yellow),
                //     )),
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
        }),
      ),
    );
  }
}
