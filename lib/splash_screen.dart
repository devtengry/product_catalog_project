import 'dart:async';
import 'package:product_catalog_project/gen/assets.gen.dart';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/text_constants.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/splash_provider.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_elevated_button.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/skip_text_button.dart';
import 'package:product_catalog_project/router/app_router.dart';

@RoutePage()
class SplashScreen extends ConsumerWidget {
  static const page = SplashRoute.new;
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rotation = ref.watch(rotationProvider);
    final isTimerDone = ref.watch(splashTimerProvider);

    if (isTimerDone) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.router.replace(const LoginRoute());
      });
    }

    return Scaffold(
      backgroundColor: kPurpleBackground,
      body: Stack(
        children: [
          Center(
            child: Transform.rotate(
              angle: rotation,
              child: SizedBox(
                width: 200.w,
                height: 130.h,
                child: Image.asset(Assets.images.logo.path),
              ),
            ),
          ),
          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthElevatedButton(
                    onPressed: () => context.router.replace(const LoginRoute()),
                    buttonText: TextConstants.authButtonTextLoginText,
                  ),
                  const SizedBox(height: 10),
                  SkipTextButton(
                    onPressed: () => context.router.replace(const LoginRoute()),
                    skipTextButton: TextConstants.skipText,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashTimerNotifier extends StateNotifier<bool> {
  Timer? _timer;

  SplashTimerNotifier() : super(false) {
    _timer = Timer(const Duration(seconds: 3), () => state = true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class RotationNotifier extends StateNotifier<double> {
  late Timer _timer;
  final Stopwatch _stopwatch = Stopwatch();

  RotationNotifier() : super(0) {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      final elapsed = _stopwatch.elapsedMilliseconds;

      final cyclePosition = elapsed % 1500;

      if (cyclePosition < 1000) {
        state = (cyclePosition / 2000) * 2 * pi;
      } else {
        state = 2 * pi;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }
}
