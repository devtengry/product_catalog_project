import 'dart:io';
import 'package:product_catalog_project/core/constants/key_constants.dart';
import 'package:product_catalog_project/features/auth/states/auth_state.dart';
import 'package:product_catalog_project/features/auth/repos/auth_repository.dart';
import 'package:product_catalog_project/features/auth/domain/session_manager.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:riverpod/riverpod.dart';

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final SessionManager _sessionManager = const SessionManager();

  AuthService(this._authRepository) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
//test
    try {
      final response = await _authRepository.login(email, password);
      final data = response.data;

      final token = data[ConstantsKeys.actionLoginDataKey]
          ?[ConstantsKeys.tokenKey] as String?;
      if (response.statusCode == HttpStatus.ok && token != null) {
        await _sessionManager.saveSession(token);
        state = state.copyWith(isAuthenticated: true);
      } else {
        state = state.copyWith(errorMessage: 'Login failed or token is null!');
      }
    } catch (e) {
      state = state.copyWith(errorMessage: 'An error occurred: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> register(String email, String password, String name) async {
    state = state.copyWith(isLoading: false, errorMessage: null);

    try {
      final response = await _authRepository.register(email, password, name);

      if (response.statusCode == HttpStatus.ok) {
        state = state.copyWith(isAuthenticated: true);
      } else {
        state = state.copyWith(errorMessage: 'Registration failed!');
      }
    } catch (e) {
      state = state.copyWith(errorMessage: 'An error occured.');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> checkSession() async {
    final isValid = await _sessionManager.isSessionValid();

    if (isValid) {
      state = state.copyWith(isAuthenticated: true);
      router.replace(const HomeRoute());
    } else {
      await _sessionManager.clearSession();
      state = state.copyWith(isAuthenticated: false);
      router.replace(const SplashRoute());
    }
  }

  Future<void> logout() async {
    await _sessionManager.clearSession();
    state = AuthState();
  }
}
