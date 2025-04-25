import 'package:product_catalog_project/features/auth/data/services/auth_service.dart';
import 'package:product_catalog_project/features/auth/data/services/concrete_session_manager.dart';
import 'package:product_catalog_project/features/auth/domain/session_manager.dart';
import 'package:product_catalog_project/features/auth/repos/auth_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:product_catalog_project/network/network_service.dart';
import '../../states/auth_state.dart';

final concreteSessionManagerProvider = Provider<SessionManager>((ref) {
  return ConcreteSessionManager();
});

final authServiceProvider = StateNotifierProvider<AuthService, AuthState>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final sessionManager = ref.watch(concreteSessionManagerProvider);

    return AuthService(authRepository, sessionManager);
  },
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(NetworkService());
});

final rememberMeProvider = StateProvider<bool>((ref) => false);
