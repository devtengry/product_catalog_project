abstract class SessionManager {
  static const int sessionTimeout = 5 * 60 * 1000;

  Future<bool> isSessionValid();

  Future<void> saveSession(String token);

  Future<void> clearSession();

  const SessionManager();
}
