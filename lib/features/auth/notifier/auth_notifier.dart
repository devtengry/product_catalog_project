import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'package:product_catalog_project/core/network/network_service.dart';
import 'package:product_catalog_project/features/auth/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  final bool isLoading;
  final String? errorMessage;
  final bool isAuthenticated;

  AuthState({
    this.isLoading = false,
    this.errorMessage,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isAuthenticated,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  AuthNotifier(this._authRepository) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _authRepository.login(email, password);
      final data = response.data;

      print('Login response data: $data');

      final token = data['action_login']?['token'] as String?;
      if (response.statusCode == HttpStatus.ok && token != null) {
        await saveToken(token); // Token'ı kaydediyoruz
        state = state.copyWith(isAuthenticated: true);
      } else {
        state = state.copyWith(errorMessage: 'Login failed or token is null!');
      }
    } catch (e, stackTrace) {
      print('Login error: $e');
      print('Stack trace: $stackTrace');
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
