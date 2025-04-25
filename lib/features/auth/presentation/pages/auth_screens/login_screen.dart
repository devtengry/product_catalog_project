import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_catalog_project/gen/assets.gen.dart';
import 'package:product_catalog_project/core/constants/text_constants.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';
import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/remember_me_checkbox.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/utils/validator_utils.dart';
import 'package:product_catalog_project/utils/error_handling.dart';
import 'package:product_catalog_project/features/auth/presentation/hooks/use_auth_form_controllers.dart';
import 'package:product_catalog_project/features/auth/presentation/hooks/use_auth_action.dart';

@RoutePage()
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formControllers = useAuthFormControllers();
    final authNotifier = ref.read(authServiceProvider.notifier);
    final authState = ref.watch(authServiceProvider);

    useEffect(() {
      Future.microtask(() async {
        final credentials = await AuthStorage.getCredentials();
        formControllers.email.text = credentials['email'] ?? '';
        formControllers.password.text = credentials['password'] ?? '';

        final remember = credentials['email']?.isNotEmpty == true &&
            credentials['password']?.isNotEmpty == true;
        ref.read(rememberMeProvider.notifier).state = remember;
      });
      return null;
    }, []);

    final onLoginPressed = useAuthAction(
      context: context,
      ref: ref,
      action: (email, password, [name]) => authNotifier.login(email, password),
      email: formControllers.email,
      password: formControllers.password,
      formKey: formControllers.formKey,
      redirectRoute: const HomeRoute(),
    );
    final snackBarTimerRef = useRef<Timer?>(null);

    listenForErrors(ref, context, snackBarTimerRef.value);

    return Scaffold(
      backgroundColor: kWhiteBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formControllers.formKey,
              child: Column(
                children: [
                  AuthLogo(logoAssetPath: Assets.images.logo.path),
                  SizedBox(height: 115.h),
                  const AuthTextHeader(
                    title: loginToYourAccountText,
                    subtitle: welcomeBackText,
                  ),
                  SizedBox(height: 80.h),
                  Column(
                    children: [
                      AuthEmailField(
                        controller: formControllers.email,
                        customValidator: (val) =>
                            ValidatorUtils.validateEmail(val, (e) {
                          SnackBarManager(context).showErrorSnackBar(e);
                        }),
                      ),
                      SizedBox(height: 24.h),
                      AuthPasswordField(
                        controller: formControllers.password,
                        customValidator: (val) =>
                            ValidatorUtils.validatePassword(val, (e) {
                          SnackBarManager(context).showErrorSnackBar(e);
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      RememberMeCheckbox(),
                      AuthSwitchTextButton(
                        text: registerText,
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
          onPressed: authState.isLoading ? null : onLoginPressed,
          text: authButtonTextLoginText,
        ),
      ),
    );
  }
}
