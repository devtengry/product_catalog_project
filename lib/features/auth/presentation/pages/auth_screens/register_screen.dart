import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';
import 'package:product_catalog_project/features/auth/presentation/states/auth_state.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:validators2/validators2.dart';

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
    if (_formKey.currentState!.validate()) {
      final authNotifier = ref.read(authNotifierProvider.notifier);

      await authNotifier.register(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
      );

      final authState = ref.read(authNotifierProvider);
      if (authState.isAuthenticated && mounted) {
        context.router.replace(const LoginRoute());
      }
    }
  }

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
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
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
                      AuthEmailField(controller: _emailController),
                      AuthPasswordField(
                        controller: _passwordController,
                        customValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty!';
                          }
                          if (!isLength(value, 6, 20)) {
                            return 'Password must be between 6 and 20 characters!';
                          }
                          if (!matches(value,
                              r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$')) {
                            return 'Password must contain at least one letter and one number!';
                          }
                          return null;
                        },
                      ),
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
                  SizedBox(height: 55.h),
                  AuthButton(
                    onPressed: authState.isLoading ? null : _onRegisterPressed,
                    text: TextConstants.authButtonTextRegisterText,
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
