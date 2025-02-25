import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/router/.app_router.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/auth_text_button.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/auth_text_field.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/auth_elevated_button.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/remember_me_checkbox.dart';
import 'package:product_catalog_project/router/app_router.dart';

final rememberMeProvider = StateProvider<bool>((ref) => false);

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  static var page;

  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final String _logoAssetPath = AssetsPath().logoAssetPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                _LoginIcon(logoAssetPath: _logoAssetPath),
                SizedBox(height: 115.h),
                Row(
                  children: [
                    Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _WelcomeBackText(),
                        _LoginToYourAccount(),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 80.h),
                Column(
                  spacing: 24,
                  children: [
                    _EmailTextBox(),
                    _PasswordTextBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RememberMeCheckbox(),
                        _RegisterTextButton(),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 55.h,
                ),
                _LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AuthElevatedButton(
      onPressed: () => router.push(HomeRoute()),
      buttonText: TextConstants.authButtonTextLoginText,
    );
  }
}

class _RegisterTextButton extends StatelessWidget {
  const _RegisterTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AuthTextButton(
      onPressed: () => router.push(RegisterRoute()),
      buttonText: TextConstants.registerText,
    );
  }
}

class _PasswordTextBox extends StatelessWidget {
  const _PasswordTextBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AuthTextField(
      isPassword: true,
      labelTextString: TextConstants.passwordLabelText,
      hintTextString: TextConstants.passwordHintText,
    );
  }
}

class _EmailTextBox extends StatelessWidget {
  const _EmailTextBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AuthTextField(
      isPassword: false,
      labelTextString: TextConstants.emailLabelText,
      hintTextString: TextConstants.emailHintText,
    );
  }
}

class _LoginToYourAccount extends StatelessWidget {
  const _LoginToYourAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      TextConstants.loginToYourAccountText,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: ProjectColors.darkPurpleText),
    );
  }
}

class _WelcomeBackText extends StatelessWidget {
  const _WelcomeBackText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      TextConstants.welcomeBackText,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ProjectColors.darkPurpleText.withValues(
              alpha: 0.6,
            ),
          ),
    );
  }
}

class _LoginIcon extends StatelessWidget {
  const _LoginIcon({
    super.key,
    required String logoAssetPath,
  }) : _logoAssetPath = logoAssetPath;

  final String _logoAssetPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 65.h,
      child: Image.asset(_logoAssetPath),
    );
  }
}
