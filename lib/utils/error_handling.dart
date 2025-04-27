import 'dart:async';
import 'package:flutter/material.dart';
import 'package:product_catalog_project/core/constants/text_constants.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';
import 'package:product_catalog_project/features/auth/states/auth_state.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String getErrorMessage(String error) {
  if (error.contains("invalid email")) {
    return errorMessageInvalidEmail;
  } else if (error.contains("password too weak")) {
    return errorMessagePasswordTooWeak;
  } else if (error.contains("email already in use")) {
    return errorMessageEmailAlreadyInUse;
  } else {
    return errorMessageAnErrorOccurred;
  }
}

void listenForErrors(
  WidgetRef ref,
  BuildContext context,
  Timer? snackBarTimer,
) {
  ref.listen<AuthState>(authServiceProvider, (previous, next) {
    if (next.errorMessage != null &&
        next.errorMessage != previous?.errorMessage) {
      snackBarTimer?.cancel();
      snackBarTimer = Timer(const Duration(seconds: 2), () {
        if (next.errorMessage != null) {
          String userFriendlyMessage = getErrorMessage(next.errorMessage!);
          SnackBarManager.showErrorSnackBar(userFriendlyMessage);
        }
      });
    }
  });
}
