import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

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
              color: ProjectColors.darkPurpleText),
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
            decoration: InputDecoration(
              filled: true,
              fillColor: ProjectColors.textFieldBackground,
              hintText: hintTextString,
              hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: min(16.sp, 16),
                  fontWeight: FontWeight.w700,
                  color: ProjectColors.darkPurpleText.withValues(alpha: 0.4)),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
