// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDTDFs1-4xhBrxzJ0nHEIndQ9l_qTA6O70',
    appId: '1:999546256777:web:5e39cfb495caf9c273f558',
    messagingSenderId: '999546256777',
    projectId: 'easybook-1d1eb',
    authDomain: 'easybook-1d1eb.firebaseapp.com',
    databaseURL: 'https://easybook-1d1eb-default-rtdb.firebaseio.com',
    storageBucket: 'easybook-1d1eb.appspot.com',
    measurementId: 'G-1RH7MJDEL2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdBl3mA9098mobqG_UoseUXakzaCNMfKU',
    appId: '1:999546256777:android:4526f80c8fdbe9e273f558',
    messagingSenderId: '999546256777',
    projectId: 'easybook-1d1eb',
    databaseURL: 'https://easybook-1d1eb-default-rtdb.firebaseio.com',
    storageBucket: 'easybook-1d1eb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIewVgAQA-55k4OOQno0_r6kvo1uoMLI0',
    appId: '1:999546256777:ios:18b0d2a05830784773f558',
    messagingSenderId: '999546256777',
    projectId: 'easybook-1d1eb',
    databaseURL: 'https://easybook-1d1eb-default-rtdb.firebaseio.com',
    storageBucket: 'easybook-1d1eb.appspot.com',
    iosBundleId: 'com.example.easybook',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIewVgAQA-55k4OOQno0_r6kvo1uoMLI0',
    appId: '1:999546256777:ios:18b0d2a05830784773f558',
    messagingSenderId: '999546256777',
    projectId: 'easybook-1d1eb',
    databaseURL: 'https://easybook-1d1eb-default-rtdb.firebaseio.com',
    storageBucket: 'easybook-1d1eb.appspot.com',
    iosBundleId: 'com.example.easybook',
  );
}
