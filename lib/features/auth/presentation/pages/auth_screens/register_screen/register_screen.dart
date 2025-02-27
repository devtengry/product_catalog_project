import 'package:auto_route/auto_route.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/auth_text_button.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/auth_text_field.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/auth_elevated_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog_project/router/app_router.dart';

@RoutePage()
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
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
                _RegisterLogo(logoAssetPath: _logoAssetPath),
                SizedBox(height: 115.h),
                Row(
                  children: [
                    Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _WelcomeText(),
                        _RegirsterAnAccountText(),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 80.h),
                Column(
                  spacing: 24,
                  children: [
                    _NameTextBox(),
                    _EmailTextBox(),
                    _PasswordTextBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _LoginTextButton(),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 55.h,
                ),
                _RegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    return AuthElevatedButton(
      onPressed: () => router.push(LoginRoute()),
      buttonText: TextConstants.authButtonTextRegisterText,
    );
  }
}

class _LoginTextButton extends StatelessWidget {
  const _LoginTextButton();

  @override
  Widget build(BuildContext context) {
    return AuthTextButton(
      onPressed: () => router.push(LoginRoute()),
      buttonText: TextConstants.loginText,
    );
  }
}

class _PasswordTextBox extends StatelessWidget {
  const _PasswordTextBox();

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      textInputType: TextInputType.name,
      isPassword: true,
      labelTextString: TextConstants.passwordLabelText,
      hintTextString: TextConstants.passwordHintText,
    );
  }
}

class _EmailTextBox extends StatelessWidget {
  const _EmailTextBox();

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      textInputType: TextInputType.emailAddress,
      hintTextString: TextConstants.emailHintText,
      labelTextString: TextConstants.emailLabelText,
      isPassword: false,
    );
  }
}

class _NameTextBox extends StatelessWidget {
  const _NameTextBox();

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      textInputType: TextInputType.none,
      hintTextString: TextConstants.nameHintText,
      labelTextString: TextConstants.nameLabelText,
      isPassword: false,
    );
  }
}

class _RegirsterAnAccountText extends StatelessWidget {
  const _RegirsterAnAccountText();

  @override
  Widget build(BuildContext context) {
    return Text(
      TextConstants.registerAnAccountText,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ProjectColors.darkPurpleText),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText();

  @override
  Widget build(BuildContext context) {
    return Text(
      TextConstants.welcomeText,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ProjectColors.darkPurpleText.withValues(
              alpha: 0.6,
            ),
          ),
      //  style: Theme.of(context)
      //      .textTheme
      //      .bodyMedium
      //      ?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}

class _RegisterLogo extends StatelessWidget {
  const _RegisterLogo({
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
