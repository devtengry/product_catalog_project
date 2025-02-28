import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

final rememberMeProvider = StateProvider<bool>((ref) => false);

class RememberMeCheckbox extends ConsumerWidget {
  const RememberMeCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rememberMe = ref.watch(rememberMeProvider);

    return InkWell(
      onTap: () => ref.read(rememberMeProvider.notifier).state = !rememberMe,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LoginCheckbox(rememberMe: rememberMe),
          _RememberMeText(),
        ],
      ),
    );
  }
}

class _RememberMeText extends StatelessWidget {
  const _RememberMeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      TextConstants.rememberMeText,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: min(12.sp, 12),
          fontWeight: FontWeight.w700,
          color: ProjectColors.purpleTextButton),
    );
  }
}

class _LoginCheckbox extends ConsumerWidget {
  const _LoginCheckbox({
    super.key,
    required this.rememberMe,
  });

  final bool rememberMe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Checkbox(
      activeColor: ProjectColors.purpleTextButton,
      side: BorderSide(color: ProjectColors.purpleTextButton, width: 2),
      value: rememberMe,
      onChanged: (value) =>
          ref.read(rememberMeProvider.notifier).state = value!,
    );
  }
}
