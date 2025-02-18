import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/widgets/login_button.dart';
import 'package:product_catalog_project/ui/widgets/skip_text_button.dart';

class SplashScreenView extends ConsumerStatefulWidget {
  const SplashScreenView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SplashScreenViewState();
}

class _SplashScreenViewState extends ConsumerState<SplashScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.purpleBackground,
      body: Stack(
        children: [
          Center(
            child: Image.asset('assets/images/logo.png'),
          ),
          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedLoginButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRouter.login),
                        buttonText: TextConstants.authButtonTextLoginText),
                  ),
                  SkipTextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.login);
                    },
                    skipTextButton: TextConstants.skipText,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
