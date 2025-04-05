import 'dart:async';
import 'package:flutter/material.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';
import 'package:product_catalog_project/features/auth/presentation/states/auth_state.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String getErrorMessage(String error) {
  if (error.contains("invalid email")) {
    return "Please enter a valid email address.";
  } else if (error.contains("password too weak")) {
    return "Your password is too weak. Please enter a stronger password.";
  } else if (error.contains("email already in use")) {
    return "This email address is already in use. Please enter a different email.";
  } else {
    return "An error occurred. Please try again.";
  }
}

void listenForErrors(
  WidgetRef ref,
  BuildContext context,
  Timer? snackBarTimer,
) {
  final snackBarManager = SnackBarManager(context);
  ref.listen<AuthState>(authNotifierProvider, (previous, next) {
    if (next.errorMessage != null &&
        next.errorMessage != previous?.errorMessage) {
      snackBarTimer?.cancel();
      snackBarTimer = Timer(const Duration(seconds: 2), () {
        if (next.errorMessage != null) {
          String userFriendlyMessage = getErrorMessage(next.errorMessage!);
          snackBarManager.showErrorSnackBar(userFriendlyMessage);
        }
      });
    }
  });
}
