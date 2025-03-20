import 'dart:io';
import 'package:product_catalog_project/core/constants/app_constants.dart';
import 'package:product_catalog_project/features/auth/presentation/states/auth_state.dart';
import 'package:product_catalog_project/features/auth/repos/auth_repository.dart';
import 'package:product_catalog_project/utils/shared_preferences_helper.dart';
import 'package:riverpod/riverpod.dart';

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  Future<void> saveToken(String token) async {
    final prefs = await getSharedPreferences();
    await prefs.setString(AppConstants.tokenKey, token);
  }

  AuthService(this._authRepository) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _authRepository.login(email, password);
      final data = response.data;

      final token = data[AppConstants.actionLoginDataKey]
          ?[AppConstants.tokenKey] as String?;
      if (response.statusCode == HttpStatus.ok && token != null) {
        await saveToken(token);
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

  void logout() {
    state = AuthState();
  }
}
