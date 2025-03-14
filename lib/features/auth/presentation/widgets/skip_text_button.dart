import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

class SkipTextButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final String skipTextButton;

  const SkipTextButton(
      {super.key, required this.onPressed, required this.skipTextButton});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 350.w,
      height: 60.h,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          skipTextButton,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: min(16.sp, 16),
                fontWeight: FontWeight.w700,
                color: ProjectColors.purpleTextButton,
              ),
        ),
      ),
    );
  }
}
