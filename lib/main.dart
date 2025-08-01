import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/login_controller_bloc.dart';
import 'package:flutter_app/bloc/login_page_bloc.dart';
import 'package:flutter_app/bottom_navigation_page.dart';
import 'package:flutter_app/get/login_page_get.dart';
import 'package:flutter_app/login_page.dart';
import 'package:flutter_app/navigation_drawer_page.dart';
import 'package:flutter_app/product/controller/form_product_controller.dart';
import 'package:flutter_app/provider/login_controller_provider.dart';
import 'package:flutter_app/provider/login_page_provider.dart';
import 'package:flutter_app/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginControllerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FormProductController(),
        ),
      ],
      child: GetMaterialApp(
        home: SplashPage(),
      ),
    );
  }
}
