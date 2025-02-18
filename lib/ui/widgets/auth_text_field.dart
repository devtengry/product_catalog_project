import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/core/theme/text_style/text_styles.dart';

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
          style: TextStyles.semiBoldTextFieldLabel(context),
        ),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: ProjectColors.textFieldBackground,
            hintText: hintTextString,
            hintStyle: TextStyles.regular16Hint40Opacity(context),
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
