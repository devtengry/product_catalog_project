import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/auth_elevated_button.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/skip_text_button.dart';

class SplashScreen extends StatelessWidget {
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
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRouter.login),
                    buttonText: TextConstants.authButtonTextLoginText,
                  ),
                  const SizedBox(height: 10),
                  SkipTextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.login);
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
