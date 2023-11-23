import 'dart:io';

import 'package:easybook/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

FirebaseApp? app;

Future<void> firebaseGlobal() async {
  try {
    if (Platform.isAndroid) {
      app = await Firebase.initializeApp(
              name: "MathQ_Firebase_Android",
              options: DefaultFirebaseOptions.android)
          .catchError((error) {
        if (kDebugMode) {
          print("Firebase initialization failure");
        }

        throw error;
      });
    } else {}
  } catch (error) {
    if (kDebugMode) {
      print(error.toString());
    }
  }
}
