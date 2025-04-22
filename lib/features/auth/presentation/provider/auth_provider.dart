import 'package:product_catalog_project/features/auth/data/services/auth_service.dart';
import 'package:product_catalog_project/features/auth/repos/auth_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:product_catalog_project/network/network_service.dart';
import '../../states/auth_state.dart';

final authNotifierProvider = StateNotifierProvider<AuthService, AuthState>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthService(authRepository);
  },
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(NetworkService());
});

final rememberMeProvider = StateProvider<bool>((ref) => false);
