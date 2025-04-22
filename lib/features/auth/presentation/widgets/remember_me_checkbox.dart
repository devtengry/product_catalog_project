import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';
import 'package:product_catalog_project/core/constants/text_constants.dart';
import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';

class RememberMeCheckbox extends ConsumerWidget {
  const RememberMeCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rememberMe = ref.watch(rememberMeProvider);

    return InkWell(
      onTap: () {
        ref.read(rememberMeProvider.notifier).state = !rememberMe;
        if (!rememberMe) {
          AuthStorage.clearCredentials();
        }
      },
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
  @override
  Widget build(BuildContext context) {
    return Text(
      TextConstants.rememberMeText,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: min(12.sp, 12),
          fontWeight: FontWeight.w700,
          color: kPurpleTextButton),
      overflow: TextOverflow.visible,
    );
  }
}

class _LoginCheckbox extends ConsumerWidget {
  const _LoginCheckbox({
    required this.rememberMe,
  });

  final bool rememberMe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Checkbox(
      activeColor: kPurpleTextButton,
      side: BorderSide(color: kPurpleTextButton, width: 2),
      value: rememberMe,
      onChanged: (value) =>
          ref.read(rememberMeProvider.notifier).state = value!,
    );
  }
}
