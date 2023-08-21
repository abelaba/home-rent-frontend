import 'package:shared_preferences/shared_preferences.dart';

class Helper{

  static Future<String?> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth-token');
  }

}