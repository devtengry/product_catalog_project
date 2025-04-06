import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Widget? leadingIcon;
  final String suffixText;

  const MainAppBar({
    super.key,
    this.leadingIcon,
    required this.suffixText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: ProjectColors.whiteBackground,
      surfaceTintColor: ProjectColors.whiteBackground,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SizedBox(
          width: 50.w,
          height: 32.h,
          child: leadingIcon,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            suffixText,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: min(20.sp, 20),
                fontWeight: FontWeight.w700,
                color: ProjectColors.darkPurpleText),
          ),
        ),
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: ProjectColors.cardBackground,
            height: 1.0.h,
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
