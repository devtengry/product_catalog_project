import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_elevated_button.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/skip_text_button.dart';
import 'package:product_catalog_project/router/app_router.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  static const page = SplashRoute.new;
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.purpleBackground,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 200.w,
              height: 130.h,
              child: Image.asset('assets/images/logo.png'),
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
                    onPressed: () => router.push(LoginRoute()),
                    buttonText: TextConstants.authButtonTextLoginText,
                  ),
                  const SizedBox(height: 10),
                  SkipTextButton(
                    onPressed: () {
                      router.push(LoginRoute());
                    },
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
