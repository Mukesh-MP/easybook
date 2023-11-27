import 'package:easybook/features/splash/screen/splash_screen.dart';
import 'package:easybook/global/global.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await firebaseGlobal();
  requestSmsPermission();

// ...

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Book',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

void requestSmsPermission() async {
  var status = await Permission.sms.status;
  if (status != PermissionStatus.granted) {
    status = await Permission.sms.request();
    if (status != PermissionStatus.granted) {
      // Handle the case where the user denies the permission
      // You may show a dialog explaining why the permission is needed
    }
  }
}
