import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';

class SessionManager {
  //TODO: burada sadece tanımla ve tanımların içini kullandığın yerde doldur
  const SessionManager();

  static const int _sessionTimeout = 5 * 60 * 1000;

  Future<bool> isSessionValid() async {
    final token = await AuthStorage.getToken();
    final tokenTime = await AuthStorage.getTokenTime();
    final now = DateTime.now().millisecondsSinceEpoch;

    return token != null &&
        tokenTime != null &&
        now - tokenTime <= _sessionTimeout;
  }

  Future<void> saveSession(String token) async {
    await AuthStorage.saveToken(token);
  }

  Future<void> clearSession() async {
    await AuthStorage.deleteToken();
  }
}
