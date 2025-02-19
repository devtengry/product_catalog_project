import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/core/theme/text_style/text_styles.dart';

class SkipTextButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final String skipTextButton;

  SkipTextButton(
      {super.key, required this.onPressed, required this.skipTextButton});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        skipTextButton,
        style: TextStyles.textButton16SemiBold(context),
      ),
    );
  }
}
