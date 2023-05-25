

import 'package:evira_store/data/shared_preference/shared_preference.dart';

class UserPreferences {
  static final sharedPreferences = SharedPrefs.instance;

  static String getUserToken() => sharedPreferences.getString("token") ?? '';
  static String getUserEmail() => sharedPreferences.getString("email") ?? '';

  static Future<void> setUserToken(String token) => sharedPreferences.setString("token", token);
  static Future<void> setUserEmail(String email) => sharedPreferences.setString("email", email);
}
