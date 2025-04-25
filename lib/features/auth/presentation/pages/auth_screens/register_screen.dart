import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_catalog_project/gen/assets.gen.dart';
import 'package:product_catalog_project/core/constants/text_constants.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';
import 'package:product_catalog_project/features/auth/presentation/hooks/use_auth_form_controllers.dart';
import 'package:product_catalog_project/features/auth/presentation/hooks/use_auth_action.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/utils/error_handling.dart';
import 'package:product_catalog_project/utils/validator_utils.dart';

@RoutePage()
class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formControllers = useAuthFormControllers(includeName: true);
    final snackBarTimerRef = useRef<Timer?>(null);
    final authNotifier = ref.read(authServiceProvider.notifier);

    final onRegisterPressed = useAuthAction(
      context: context,
      ref: ref,
      action: (email, password, [name]) =>
          authNotifier.register(email, password, name!),
      email: formControllers.email,
      password: formControllers.password,
      name: formControllers.name,
      formKey: formControllers.formKey,
      redirectRoute: const LoginRoute(),
    );

    final authState = ref.watch(authServiceProvider);

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
                    title: registerAnAccountText,
                    subtitle: welcomeText,
                  ),
                  SizedBox(height: 80.h),
                  Column(
                    spacing: 24,
                    children: [
                      AuthNameField(controller: formControllers.name!),
                      AuthEmailField(
                        controller: formControllers.email,
                        customValidator: (val) =>
                            ValidatorUtils.validateEmail(val, (e) {
                          SnackBarManager(context).showErrorSnackBar(e);
                        }),
                      ),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      AuthSwitchTextButton(
                        text: loginText,
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
          onPressed: authState.isLoading ? null : onRegisterPressed,
          text: authButtonTextRegisterText,
        ),
      ),
    );
  }
}
