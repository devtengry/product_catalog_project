import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const _tokenKey = 'auth_token';
  static const _tokenTimeKey = 'auth_token_time';
  static const _emailKey = 'remembered_email';
  static const _passwordKey = 'remembered_password';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setInt(_tokenTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final tokenTime = prefs.getInt(_tokenTimeKey);

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
    return prefs.getInt(_tokenTimeKey);
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_tokenTimeKey);
  }

  static Future<void> saveCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
  }

  static Future<Map<String, String?>> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString(_emailKey),
      'password': prefs.getString(_passwordKey),
    };
  }

  static Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
  }
}
