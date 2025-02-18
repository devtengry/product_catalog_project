import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

class ElevatedLoginButton extends ConsumerWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const ElevatedLoginButton(
      {super.key, required this.buttonText, required this.onPressed});

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
        backgroundColor: WidgetStateProperty.all(
          ProjectColors.elevatedButton,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: ProjectColors.whiteBackground,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
