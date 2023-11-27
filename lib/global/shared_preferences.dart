import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static SharedPreferences? prefs;

  factory Shared() {
    if (prefs != null) {
      initsharedpreference();
    }

    return Shared();
  }

  static initsharedpreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  getClientId() {
    prefs?.getString('clientId');
  }

  setClientId(clientId) {
    prefs?.setString("clientId", clientId);
  }
}
