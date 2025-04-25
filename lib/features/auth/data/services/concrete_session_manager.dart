import 'package:product_catalog_project/features/auth/domain/session_manager.dart';
import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';
import 'dart:core';

class ConcreteSessionManager extends SessionManager {
  const ConcreteSessionManager();

  @override
  Future<bool> isSessionValid() async {
    final token = await AuthStorage.getToken();
    final tokenTime = await AuthStorage.getTokenTime();
    final now = DateTime.now().millisecondsSinceEpoch;

    return token != null &&
        tokenTime != null &&
        now - tokenTime <= SessionManager.sessionTimeout;
  }

  @override
  Future<void> saveSession(String token) async {
    await AuthStorage.saveToken(token);
  }

  @override
  Future<void> clearSession() async {
    await AuthStorage.deleteToken();
  }
}
