import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/login_controller_bloc.dart';
import 'package:flutter_app/bloc/login_page_bloc.dart';
import 'package:flutter_app/bottom_navigation_page.dart';
import 'package:flutter_app/config/config_notification.dart';
import 'package:flutter_app/employee/home_list_employee_page.dart';
import 'package:flutter_app/get/login_page_get.dart';
import 'package:flutter_app/login_page.dart';
import 'package:flutter_app/maps_controller.dart';
import 'package:flutter_app/maps_page.dart';
import 'package:flutter_app/navigation_drawer_page.dart';
import 'package:flutter_app/product/controller/form_product_controller.dart';
import 'package:flutter_app/provider/login_controller_provider.dart';
import 'package:flutter_app/provider/login_page_provider.dart';
import 'package:flutter_app/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  askPermissionNotification();
  runApp(const MyApp());
}

void askPermissionNotification() async {
  PermissionStatus permissionNotif = await Permission.notification.status;
  if (permissionNotif.isGranted) {
    ConfigNotification().initialNotification();
  } else {
    permissionNotif = await Permission.notification.request();
    if (permissionNotif.isGranted) {
      ConfigNotification().initialNotification();
    }
  }
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
        ChangeNotifierProvider(
          create: (context) => MapsController(),
        )
      ],
      child: GetMaterialApp(home: MapsPage()
          //HomeListEmployeePage()
          //SplashPage(),
          ),
    );
  }
}
