import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:product_catalog_project/core/network/network_service.dart';
import 'package:product_catalog_project/features/auth/repos/auth_repository.dart';
import 'package:riverpod/riverpod.dart';
import '../states/auth_state.dart';

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AuthService(this.authRepository) : super(AuthState.initial());

  Future<bool> checkSession() async {
    final token = await _secureStorage.read(key: "auth_token");
    if (token != null && token.isNotEmpty) {
      state = state.copyWith(isAuthenticated: true);
      return true;
    } else {
      state = state.copyWith(isAuthenticated: false);
      return false;
    }
  }

  Future<void> login(String email, String password) async {
    final token = await authRepository.login(email, password);
    await _secureStorage.write(key: "auth_token", value: token);
    state = state.copyWith(isAuthenticated: true);
  }

  Future<void> register(String email, String password) async {
    final token = await authRepository.register(email, password);
    await _secureStorage.write(key: "auth_token", value: token);
    state = state.copyWith(isAuthenticated: true);
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: "auth_token");
    state = state.copyWith(isAuthenticated: false);
  }
}

final authNotifierProvider = StateNotifierProvider<AuthService, AuthState>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthService(authRepository);
  },
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(NetworkService());
});
