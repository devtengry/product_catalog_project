import 'package:product_catalog_project/core/constants/key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(authTokenKey, token);
    await prefs.setInt(
      tokenTimeKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(authTokenKey);
  }

  static Future<int?> getTokenTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(tokenTimeKey);
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(authTokenKey);
    await prefs.remove(tokenTimeKey);
  }

  static Future<void> saveCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(emailKey, email);
    await prefs.setString(passwordKey, password);
  }

  static Future<Map<String, String?>> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString(emailKey),
      'password': prefs.getString(passwordKey),
    };
  }

  static Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(emailKey);
    await prefs.remove(passwordKey);
  }
}
