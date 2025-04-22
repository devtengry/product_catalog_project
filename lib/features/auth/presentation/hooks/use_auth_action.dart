import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';

typedef AuthCallback = Future<void> Function(String email, String password,
    [String? name]);

VoidCallback useAuthAction({
  required BuildContext context,
  required WidgetRef ref,
  required AuthCallback action,
  required TextEditingController email,
  required TextEditingController password,
  TextEditingController? name,
  required GlobalKey<FormState> formKey,
  required PageRouteInfo<dynamic> redirectRoute,
}) {
  return () async {
    if (email.text.isEmpty ||
        password.text.isEmpty ||
        (name?.text.isEmpty ?? false)) {
      SnackBarManager(context).showErrorSnackBar('Please fill out all fields!');
      return;
    }

    if (formKey.currentState?.validate() ?? false) {
      await action(email.text, password.text, name?.text);

      if (ref.read(authNotifierProvider).isAuthenticated && context.mounted) {
        context.router.replace(redirectRoute);
      }
    }
  };
}
