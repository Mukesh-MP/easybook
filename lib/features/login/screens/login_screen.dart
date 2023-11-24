import 'package:easybook/features/home/screens/homescreen.dart';
import 'package:easybook/features/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromARGB(255, 7, 167, 167),
              Color.fromARGB(255, 86, 216, 239),
              Color.fromARGB(255, 237, 246, 246),
              Color.fromARGB(255, 235, 249, 249),
              Color.fromARGB(255, 245, 249, 249),
              Color.fromARGB(255, 248, 251, 251),
              Color.fromARGB(255, 12, 170, 170),
            ])),
        padding: EdgeInsets.all(size.width * .10),
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Hello", style: TextStyle(fontSize: 35)),
                        Text("Sign in to your account",
                            style: TextStyle(fontSize: 23)),
                      ],
                    ),
                  ],
                )),
            Container(
              height: size.height * 0.06,
              child: TextField(
                  controller: loginController.usercodeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: "Please enter your usercode",
                      labelStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.teal.shade100.withOpacity(0.5),
                      filled: true)),
            ),
            SizedBox(height: size.height * 0.04),
            Container(
              height: size.height * 0.06,
              child: TextField(
                  controller: loginController.passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: "Please enter your password",
                      labelStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.teal.shade100.withOpacity(0.5),
                      filled: true)),
            ),
            SizedBox(height: size.height * 0.04),
            InkWell(
                onTap: () {
                  loginController.getClientDetails();
                },
                child: Container(
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LOG IN",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ],
                  ),
                )),
            FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  String version = snapshot.data?.version ?? "1.0.0";

                  return Center(
                    child: Text(
                      "V " + version,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'OpenSans-Medium',
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
