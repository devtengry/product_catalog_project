import 'package:product_catalog_project/splash_screen.dart';
import 'package:riverpod/riverpod.dart';

final splashTimerProvider =
    StateNotifierProvider.autoDispose<SplashTimerNotifier, bool>(
  (ref) => SplashTimerNotifier(),
);
