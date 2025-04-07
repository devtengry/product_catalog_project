import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/splash_screen.dart';
import 'package:riverpod/riverpod.dart';

final rotationProvider =
    StateNotifierProvider.autoDispose<RotationNotifier, double>(
  (ref) => RotationNotifier(),
);

final splashTimerProvider =
    StateNotifierProvider.autoDispose<SplashTimerNotifier, bool>(
  (ref) => SplashTimerNotifier(),
);
