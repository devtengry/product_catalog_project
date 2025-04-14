import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/utils/validator_utils.dart';
import 'package:product_catalog_project/core/constants/text_constants.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/utils/error_handling.dart';

@RoutePage()
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _logoAssetPath = AssetsPath().logoAssetPath;

  Timer? _snackBarTimer;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _snackBarTimer?.cancel();
    super.dispose();
  }

  void _onRegisterPressed() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      SnackBarManager(context).showErrorSnackBar('Please fill out all fields!');
      return;
    }

    if (_formKey.currentState!.validate()) {
      final authNotifier = ref.read(authNotifierProvider.notifier);

      await authNotifier.register(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
      );

      if (ref.read(authNotifierProvider).isAuthenticated && mounted) {
        context.router.replace(const LoginRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    listenForErrors(ref, context, _snackBarTimer);

    String? emailValidator(String? value) {
      return ValidatorUtils.validateEmail(value, (error) {
        SnackBarManager(context).showErrorSnackBar(error);
      });
    }

    String? passwordValidator(String? value) {
      return ValidatorUtils.validatePassword(value, (error) {
        SnackBarManager(context).showErrorSnackBar(error);
      });
    }

    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthLogo(logoAssetPath: _logoAssetPath),
                  SizedBox(height: 115.h),
                  const AuthTextHeader(
                    title: TextConstants.registerAnAccountText,
                    subtitle: TextConstants.welcomeText,
                  ),
                  SizedBox(height: 80.h),
                  Column(
                    spacing: 24,
                    children: [
                      AuthNameField(controller: _nameController),
                      AuthEmailField(
                        controller: _emailController,
                        customValidator: emailValidator,
                      ),
                      AuthPasswordField(
                        controller: _passwordController,
                        customValidator: passwordValidator,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      AuthSwitchTextButton(
                        text: TextConstants.loginText,
                        route: LoginRoute(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: AuthButton(
          onPressed: authState.isLoading ? null : _onRegisterPressed,
          text: TextConstants.authButtonTextRegisterText,
        ),
      ),
    );
  }
}
