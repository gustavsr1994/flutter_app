import 'package:flutter/material.dart';
import 'package:flutter_app/get/login_page_get.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  String name = "";
  final box = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = box.read("name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                box.erase();
                Get.to(LoginPageGet());
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text("Name: $name"),
      ),
    );
  }
}
