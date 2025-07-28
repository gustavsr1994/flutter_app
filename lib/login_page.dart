import 'package:flutter/material.dart';
import 'package:flutter_app/bottom_navigation_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String myName = "";
  final _formKey = GlobalKey<FormState>();
  bool statusObsecure = true;

  TextEditingController _nameField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _nameField,
                  decoration: InputDecoration(
                      labelText: 'Nama',
                      labelStyle: TextStyle(fontSize: 20),
                      hintText: 'Masukan Nama Anda',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: _passwordField,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Kolom ini wajib diisi";
                    }
                    return null;
                  },
                  obscureText: statusObsecure,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 20),
                      hintText: 'Masukan Password Anda',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              statusObsecure = !statusObsecure;
                            });
                          },
                          icon: Icon(statusObsecure
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavigationPage(),
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Data Kosong !!!")));
                    }

                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => BottomNavigationPage(),
                    //     ));
                  },
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
    );
  }
}
