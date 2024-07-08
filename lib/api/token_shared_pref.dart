import 'package:shared_preferences/shared_preferences.dart';

class Token {
  Future<String?> gettoken()  async{
   
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
