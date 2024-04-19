import 'package:shared_preferences/shared_preferences.dart';

String _keyToken = "token";

class SharedPref {
  static void saveToken(
    String token,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(
      _keyToken,
      token,
    );
  }

  static Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString(_keyToken);
  }
}
