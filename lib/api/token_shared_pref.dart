import 'package:shared_preferences/shared_preferences.dart';


Future<void> save_pref(lang) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  pref.setString('lang', lang).toString();
}

Future<String?> getlang() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('lang').toString();
}