// import 'dart:async';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SecureStorage {
//   static final SecureStorage _singleton = SecureStorage._internal();

//   SecureStorage._internal();

//   factory SecureStorage() {
//     return _singleton;
//   }

//   final _storage = const FlutterSecureStorage(
//       aOptions: AndroidOptions(encryptedSharedPreferences: true));
//   // Future writeSecureData(String key, String value) async {
//   //   var writeData = await _storage.write(key: key, value: value);
//   //   return writeData;
//   // }

//   // Future readSecureData(String key) async {
//   //   var readData = await _storage.read(key: key);
//   //   return readData;
//   // }

//   setUserCode(String usercode) async {
//     await _storage.write(key: "usercode", value: usercode);
//   }

//   getUserCode() async {
//     String? usercode = await _storage.read(key: "usercode");
//     return usercode;
//   }

//   // setClientID(String? clientId) async {
//   //   await _storage.write(key: "clientId", value: clientId);
//   // }

//   // getClientID() async {
//   //   String? clientId = await _storage.read(key: "clientId");
//   //   return clientId;
//   // }

//   Future deleteSecureData(String key) async {
//     var deleteData = await _storage.delete(key: key).catchError((error) {
//       throw error;
//     });
//     return deleteData;
//   }

//   setPassword(String? password) async {
//     await _storage.write(key: 'UserPassword', value: password);
//   }

//   Future<String> getPassword() async {
//     String? password = await _storage.read(key: "UserPassword");
//     return password!;
//   }
// }
