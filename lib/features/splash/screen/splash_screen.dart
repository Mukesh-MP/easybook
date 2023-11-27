import 'package:easybook/features/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(const LoginScreen());
      Get.to(() => LoginScreen());
    });
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromARGB(255, 77, 142, 146),
              Color.fromARGB(255, 58, 178, 189),
              Color.fromARGB(255, 108, 168, 172)
            ])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Easy",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 45,
                  color: Color.fromARGB(255, 24, 2, 62)),
            ),
            Text(
              "Book",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 60,
                  color: Colors.orangeAccent[400]),
            )
          ],
        ),
      ),
    );
  }
}

showToast({required String msg, Color? backgroundColor, Color? textColor}) {
  Get.snackbar(
    "",
    "",
    // maxWidth: 250,
    maxWidth: double.infinity,
    margin: const EdgeInsets.only(
      right: 50,
      left: 50,
    ),
    barBlur: 0,
    overlayBlur: 0,
    backgroundColor: Colors.transparent,
    snackPosition: SnackPosition.BOTTOM,
    messageText: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  msg,
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          ),
        )),
  );
}
