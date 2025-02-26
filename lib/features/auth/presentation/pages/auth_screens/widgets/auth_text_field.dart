import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

class AuthTextField extends ConsumerWidget {
  final String hintTextString;
  final String labelTextString;
  final bool isPassword;
  final TextButton? counterText;

  const AuthTextField({
    super.key,
    required this.hintTextString,
    required this.labelTextString,
    required this.isPassword,
    this.counterText,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelTextString,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ProjectColors.darkPurpleText),
        ),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: ProjectColors.textFieldBackground,
            hintText: hintTextString,
            hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ProjectColors.darkPurpleText.withValues(alpha: 0.4)),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}
