import 'package:flutter/material.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';
import 'package:product_catalog_project/utils/keys.dart';

class SnackBarManager {
  SnackBarManager._();

  static void showErrorSnackBar(String message) {
    final scaffoldState = scaffoldMessengerKey.currentState;

    if (scaffoldState == null) {
      return;
    }

    scaffoldState.clearSnackBars();

    scaffoldState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        backgroundColor: kSnackBarColor,
        elevation: 0,
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
