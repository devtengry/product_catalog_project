import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';

class AuthElevatedButton extends ConsumerWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final int? bookPrice;

  const AuthElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.bookPrice,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return SizedBox(
      width: 350.w,
      height: 60.h,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: kWhiteBackground,
            fontSize: min(16.sp, 16),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
