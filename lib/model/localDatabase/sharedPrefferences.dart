import 'package:shared_preferences/shared_preferences.dart';

String loginKey = "isLoggedIn";

dynamic getFromSharedPrefs(String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.get(key);
}

void setAsLoggedIn() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool(loginKey, true);
}

void setAsLoggedOut() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool(loginKey, false);
}

Future<bool?> isLoggedIn() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getBool(loginKey);
}
