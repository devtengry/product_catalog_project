import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';
import 'package:product_catalog_project/features/auth/presentation/states/auth_state.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:validators2/validators2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_text_button.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_elevated_button.dart';

@RoutePage()
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final String _logoAssetPath = AssetsPath().logoAssetPath;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _snackBarTimer?.cancel();

    super.dispose();
  }

  void _onRegisterPressed() async {
    if (_formKey.currentState!.validate()) {
      final authNotifier = ref.read(authNotifierProvider.notifier);

      await authNotifier.register(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
      );

      final authState = ref.read(authNotifierProvider);
      if (authState.isAuthenticated && _formKey.currentState!.validate()) {
        router.replace(const LoginRoute());
      }
    }
  }

  Timer? _snackBarTimer;
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final snackBarManager = SnackBarManager(context);
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (mounted &&
          next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        _snackBarTimer?.cancel();
        _snackBarTimer = Timer(const Duration(seconds: 2), () {
          if (mounted) {
            snackBarManager.showErrorSnackBar(next.errorMessage!);
          }
        });
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
                      _NameTextBox(
                        controller: _nameController,
                      ),
                      _EmailTextBox(
                        controller: _emailController,
                      ),
                      _PasswordTextBox(
                        controller: _passwordController,
                      ),
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
                  _RegisterButton(
                    onPressed: authState.isLoading ? null : _onRegisterPressed,
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

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AuthElevatedButton(
      onPressed: onPressed,
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
          if (!isLength(value, 6, 20)) {
            return 'Password must be between 6 and 20 characters!';
          }
          if (!matches(value, r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$')) {
            return 'Password must contain at least one letter and one number!';
          }
          return null;
        });
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
        hintTextString: TextConstants.emailHintText,
        labelTextString: TextConstants.emailLabelText,
        isPassword: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'E-Mail cannot be empty!';
          }
          if (!isEmail(value)) {
            return 'Please enter a valid e-mail!';
          }
          return null;
        });
  }
}

class _NameTextBox extends StatelessWidget {
  const _NameTextBox({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
        controller: controller,
        textInputType: TextInputType.text,
        hintTextString: TextConstants.nameHintText,
        labelTextString: TextConstants.nameLabelText,
        isPassword: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Name cannot be empty!';
          }
          if (!isLength(value, 2, 50)) {
            return 'Name must be between 2 and 50 characters!';
          }
          return null;
        });
  }
}

class _RegirsterAnAccountText extends StatelessWidget {
  const _RegirsterAnAccountText();

  @override
  Widget build(BuildContext context) {
    return Text(
      TextConstants.registerAnAccountText,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: 20.sp,
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
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: ProjectColors.darkPurpleText.withValues(
              alpha: 0.6,
            ),
          ),
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
