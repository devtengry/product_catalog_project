import 'package:product_catalog_project/core/constants/key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ConstantsKeys.authTokenKey, token);
    await prefs.setInt(
        ConstantsKeys.tokenTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(ConstantsKeys.authTokenKey);
    final tokenTime = prefs.getInt(ConstantsKeys.tokenTimeKey);

    if (token != null && tokenTime != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - tokenTime <= 5 * 60 * 1000) {
        return token;
      } else {
        await deleteToken();
      }
    }
    return null;
  }

  static Future<int?> getTokenTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(ConstantsKeys.tokenTimeKey);
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(ConstantsKeys.authTokenKey);
    await prefs.remove(ConstantsKeys.tokenTimeKey);
  }

  static Future<void> saveCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ConstantsKeys.emailKey, email);
    await prefs.setString(ConstantsKeys.passwordKey, password);
  }

  static Future<Map<String, String?>> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString(ConstantsKeys.emailKey),
      'password': prefs.getString(ConstantsKeys.passwordKey),
    };
  }

  static Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(ConstantsKeys.emailKey);
    await prefs.remove(ConstantsKeys.passwordKey);
  }
}
