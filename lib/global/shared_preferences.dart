import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static SharedPreferences? prefs;

  // Use a private constructor to enforce singleton pattern
  Shared._();

  // Use a factory constructor to initialize SharedPreferences if not already initialized
  factory Shared() {
    if (prefs == null) {
      initSharedPreferences();
    }
    return Shared._();
  }

  static Future<void> initSharedPreferences() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  String? getClientId() {
    return prefs?.getString('clientId');
  }

  Future<void> setClientId(String clientId) async {
    await prefs?.setString("clientId", clientId);
  }

  String? getClientName() {
    return prefs?.getString('clientName');
  }

  Future<void> setClientName(String clientName) async {
    await prefs?.setString("clientName", clientName);
  }
}
