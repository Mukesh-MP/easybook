import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easybook/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

FirebaseApp? app;

Future<void> firebaseGlobal() async {
  try {
    if (Platform.isAndroid) {
      app = await Firebase.initializeApp(
        name: "MathQ_Firebase_Android",
        options: DefaultFirebaseOptions.android,
      ).catchError((error) {
        if (kDebugMode) {
          print("Firebase initialization failure");
        }

        throw error;
      });
      FirebaseFirestore.instance.settings = Settings(
          persistenceEnabled: false,
          cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
    } else {}
  } catch (error) {
    if (kDebugMode) {
      print(error.toString());
    }
  }
}
