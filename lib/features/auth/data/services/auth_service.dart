import 'dart:io';
import 'package:product_catalog_project/core/constants/app_constants.dart';
import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';
import 'package:product_catalog_project/features/auth/presentation/states/auth_state.dart';
import 'package:product_catalog_project/features/auth/repos/auth_repository.dart';
import 'package:riverpod/riverpod.dart';

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthService(this._authRepository) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _authRepository.login(email, password);
      final data = response.data;

      final token = data[AppConstants.actionLoginDataKey]
          ?[AppConstants.tokenKey] as String?;
      if (response.statusCode == HttpStatus.ok && token != null) {
        await AuthStorage.saveToken(token);
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
    final token = await AuthStorage.getToken();
    if (token != null) {
      final tokenTime = await AuthStorage.getTokenTime();
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      if (currentTime - tokenTime! <= 5 * 60 * 1000) {
        state = state.copyWith(isAuthenticated: true);
      } else {
        state = state.copyWith(isAuthenticated: false);
        await AuthStorage.deleteToken();
      }
    } else {
      state = state.copyWith(isAuthenticated: false);
    }
  }

  Future<void> logout() async {
    await AuthStorage.deleteToken();
    state = AuthState();
  }
}
