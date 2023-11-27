import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easybook/features/home/screens/homescreen.dart';
import 'package:easybook/features/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// int? clientId = 1;

class LoginController extends GetxController {
  TextEditingController usercodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<QueryDocumentSnapshot<Object?>>? clientData;
  String? clientPassword;

  getClientDetails() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    FirebaseFirestore data = FirebaseFirestore.instance;
    QuerySnapshot querySnapshotClientId = await data
        .collection("client")
        .where("userCode", isEqualTo: usercodeController.text)
        .get()
        .catchError((error) => showToast(
            msg: "Usercode mismatch or server error",
            backgroundColor: Colors.red,
            textColor: Colors.white));

    // Check if there is any document
    if (querySnapshotClientId.docs.isNotEmpty) {
      clientData = querySnapshotClientId.docs;

      clientPassword = clientData![0]["password"];

      if (clientPassword.toString().toUpperCase() ==
          passwordController.text.toString().toUpperCase()) {
        int clientId = clientData![0]["clientId"];
        // CommonStorage().clientId = clientId.toString();

        await prefs.setString('clientId', clientId.toString());

        Get.to(() => HomeScreen());
      } else {
        showToast(
            msg: "Wrong password",
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    } else {
      showToast(
          msg: "Plase enter valid usercode",
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }
}
