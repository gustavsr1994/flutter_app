import 'package:flutter/material.dart';
import 'package:flutter_app/bottom_navigation_page.dart';
import 'package:flutter_app/provider/login_page_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final box = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
      () {
        var token = box.read("token");
        if (token != null) {
          Get.to(BottomNavigationPage());
        } else {
          Get.to(LoginPageProvider());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
