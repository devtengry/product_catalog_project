import 'dart:io';
import 'package:product_catalog_project/features/auth/data/repository/auth_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:product_catalog_project/core/network/network_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../states/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  AuthNotifier(this._authRepository) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _authRepository.login(email, password);
      final data = response.data;

      final token = data['action_login']?['token'] as String?;
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

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthNotifier(authRepository);
  },
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(NetworkService());
});
