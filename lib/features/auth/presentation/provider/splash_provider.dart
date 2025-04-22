import 'package:product_catalog_project/splash_screen.dart';
import 'package:riverpod/riverpod.dart';

final rotationProvider =
    StateNotifierProvider.autoDispose<RotationNotifier, double>(
  (ref) => RotationNotifier(),
);

final splashTimerProvider =
    StateNotifierProvider.autoDispose<SplashTimerNotifier, bool>(
  (ref) => SplashTimerNotifier(),
);
