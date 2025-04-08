// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/text_constants.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/remember_me_checkbox.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/utils/error_handling.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Timer? _snackBarTimer;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final credentials = await AuthStorage.getCredentials();
    if (!mounted) return;

    _emailController.text = credentials['email'] ?? '';
    _passwordController.text = credentials['password'] ?? '';

    final remember = credentials['email']?.isNotEmpty == true &&
        credentials['password']?.isNotEmpty == true;

    ref.read(rememberMeProvider.notifier).state = remember;
  }

  Future<void> _onLoginPressed() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      SnackBarManager(context).showErrorSnackBar('Please fill out all fields!');
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      final authNotifier = ref.read(authNotifierProvider.notifier);
      await authNotifier.login(
        _emailController.text,
        _passwordController.text,
      );

      final authState = ref.read(authNotifierProvider);
      if (authState.isAuthenticated && mounted) {
        final shouldRemember = ref.read(rememberMeProvider);
        shouldRemember
            ? await AuthStorage.saveCredentials(
                _emailController.text, _passwordController.text)
            : await AuthStorage.clearCredentials();

        context.router.replace(const HomeRoute());
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _snackBarTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    listenForErrors(ref, context, _snackBarTimer);

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
                  AuthLogo(logoAssetPath: AssetsPath().logoAssetPath),
                  SizedBox(height: 115.h),
                  const AuthTextHeader(
                    title: TextConstants.loginToYourAccountText,
                    subtitle: TextConstants.welcomeBackText,
                  ),
                  SizedBox(height: 80.h),
                  Column(
                    spacing: 24,
                    children: [
                      AuthEmailField(controller: _emailController),
                      AuthPasswordField(controller: _passwordController),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      RememberMeCheckbox(),
                      AuthSwitchTextButton(
                        text: TextConstants.registerText,
                        route: RegisterRoute(),
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
          onPressed: authState.isLoading ? null : _onLoginPressed,
          text: TextConstants.authButtonTextLoginText,
        ),
      ),
    );
  }
}
