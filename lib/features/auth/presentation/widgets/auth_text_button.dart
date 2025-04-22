import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';

class AuthTextButton extends ConsumerWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  const AuthTextButton(
      {super.key, required this.buttonText, required this.onPressed});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(12.sp, 12),
            fontWeight: FontWeight.w700,
            color: kPurpleTextButton),
      ),
    );
  }
}
