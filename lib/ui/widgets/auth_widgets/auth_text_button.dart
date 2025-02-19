import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/theme/text_style/text_styles.dart';

class AuthTextButton extends ConsumerWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  AuthTextButton(
      {super.key, required this.buttonText, required this.onPressed});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyles.textButton12Bold(context),
      ),
    );
  }
}
