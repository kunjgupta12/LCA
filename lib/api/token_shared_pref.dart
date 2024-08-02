import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static const String _keyAccessToken = 'token';

  // Save the access token
  static Future<void> setAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAccessToken, token);
  }

  // Retrieve the access token
  static Future<String> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessToken).toString();
  }

  // Remove the access token
  static Future<void> removeAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAccessToken);
  }
}

Future<void> save_pref(lang) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  pref.setString('lang', lang).toString();
}

Future<String?> getlang() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('lang').toString();
}