import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';

class BuyButton extends ConsumerWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final String bookPrice;

  const BuyButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.bookPrice,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(kElevatedButton),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$bookPrice \$',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: min(16.sp, 16),
                color: kWhiteText),
          ),
          Text(
            buttonText,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: min(16.sp, 16),
                fontWeight: FontWeight.w700,
                color: kWhiteText),
          ),
        ],
      ),
    );
  }
}
