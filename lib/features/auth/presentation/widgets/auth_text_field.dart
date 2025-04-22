import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/app_theme.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';

class AuthTextField extends ConsumerWidget {
  final String hintTextString;
  final String labelTextString;
  final bool isPassword;
  final TextButton? counterText;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.hintTextString,
    required this.labelTextString,
    required this.isPassword,
    required this.textInputType,
    this.controller,
    this.counterText,
    this.validator,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelTextString,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: min(14.sp, 14),
              fontWeight: FontWeight.w600,
              color: kDarkPurpleText),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 350.w,
            maxHeight: 50.h,
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: textInputType,
            obscureText: isPassword,
            validator: validator,
            decoration: AppTheme.textFieldDecoration(context, hintTextString),
          ),
        ),
      ],
    );
  }
}
