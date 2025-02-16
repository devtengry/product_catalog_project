import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      builder: (context, child) => Scaffold(
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
                    ScreenUtilInit(
                      designSize: Size(350, 60),
                      child: SizedBox(
                        width: 350,
                        height: 60,
                        child: ElevatedLoginButton(),
                      ),
                    ),
                    _loginTextButton()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _loginTextButton extends StatelessWidget {
  const _loginTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Skip',
        style: TextStyle(
          color: ProjectColors.purpleTextButton,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ElevatedLoginButton extends StatelessWidget {
  const ElevatedLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          backgroundColor:
              WidgetStateProperty.all(ProjectColors.elevatedButton)),
      child: const Text(
        'Login',
        style: TextStyle(
          color: ProjectColors.whiteBackground,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
