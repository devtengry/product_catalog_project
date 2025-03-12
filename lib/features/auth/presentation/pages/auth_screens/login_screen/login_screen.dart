import 'dart:math';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:validators2/validators2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/features/auth/presentation/notifier/auth_notifier.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/auth_text_field.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/auth_text_button.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/auth_elevated_button.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/widgets/remember_me_checkbox.dart';

import '../../../states/auth_state.dart';

final rememberMeProvider = StateProvider<bool>((ref) => false);

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final String _logoAssetPath = AssetsPath().logoAssetPath;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      final authNotifier = ref.read(authNotifierProvider.notifier);
      await authNotifier.login(_emailController.text, _passwordController.text);
      if (ref.read(authNotifierProvider).isAuthenticated) {
        if (mounted) {
          context.router.replace(const HomeRoute());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.isAuthenticated) {
        context.router.replace(const HomeRoute());
      } else if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
    });
    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
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
                      _EmailTextBox(
                        controller: _emailController,
                      ),
                      _PasswordTextBox(
                        controller: _passwordController,
                      ),
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
                  _LoginButton(
                    onPressed: authState.isLoading ? null : _onLoginPressed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//---------------------------------- WIDGETS ----------------------------------
//---------------------------------- WIDGETS ----------------------------------
//---------------------------------- WIDGETS ----------------------------------
//---------------------------------- WIDGETS ----------------------------------
//---------------------------------- WIDGETS ----------------------------------
//---------------------------------- WIDGETS ----------------------------------
//---------------------------------- WIDGETS ----------------------------------

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AuthElevatedButton(
      onPressed: onPressed,
      buttonText: TextConstants.authButtonTextLoginText,
    );
  }
}

class _RegisterTextButton extends StatelessWidget {
  const _RegisterTextButton();

  @override
  Widget build(BuildContext context) {
    return AuthTextButton(
      onPressed: () => router.push(RegisterRoute()),
      buttonText: TextConstants.registerText,
    );
  }
}

class _PasswordTextBox extends StatelessWidget {
  const _PasswordTextBox({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      controller: controller,
      textInputType: TextInputType.text,
      isPassword: true,
      labelTextString: TextConstants.passwordLabelText,
      hintTextString: TextConstants.passwordHintText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty!';
        }

        return null;
      },
    );
  }
}

class _EmailTextBox extends StatelessWidget {
  const _EmailTextBox({required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      controller: controller,
      textInputType: TextInputType.emailAddress,
      isPassword: false,
      labelTextString: TextConstants.emailLabelText,
      hintTextString: TextConstants.emailHintText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'E-Mail cant be empty!';
        } else if (!isEmail(value)) {
          return 'Please enter a valid e-mail!';
        }

        return null;
      },
    );
  }
}

class _LoginToYourAccount extends StatelessWidget {
  const _LoginToYourAccount();

  @override
  Widget build(BuildContext context) {
    return Text(
      TextConstants.loginToYourAccountText,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: min(20.sp, 20),
          color: ProjectColors.darkPurpleText),
    );
  }
}

class _WelcomeBackText extends StatelessWidget {
  const _WelcomeBackText();

  @override
  Widget build(BuildContext context) {
    return Text(
      TextConstants.welcomeBackText,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: min(16.sp, 16),
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
