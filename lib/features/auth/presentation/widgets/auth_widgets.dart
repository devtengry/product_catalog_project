import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:product_catalog_project/core/constants/text_constants.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_elevated_button.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_text_button.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:validators2/validators2.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart'; // SnackBarManager importu

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AuthElevatedButton(
      onPressed: onPressed,
      buttonText: text,
    );
  }
}

class AuthSwitchTextButton extends StatelessWidget {
  const AuthSwitchTextButton({
    super.key,
    required this.text,
    required this.route,
  });

  final String text;
  final PageRouteInfo route;

  @override
  Widget build(BuildContext context) {
    return AuthTextButton(
      onPressed: () => context.router.push(route),
      buttonText: text,
    );
  }
}

class AuthTextHeader extends StatelessWidget {
  const AuthTextHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: min(16.sp, 16),
                    fontWeight: FontWeight.w600,
                    color: kDarkPurpleText.withAlpha(150),
                  ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: min(20.sp, 20),
                    fontWeight: FontWeight.w700,
                    color: kDarkPurpleText,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key, required this.logoAssetPath});

  final String logoAssetPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 65.h,
      child: Image.asset(logoAssetPath),
    );
  }
}

class AuthEmailField extends StatelessWidget {
  const AuthEmailField({
    super.key,
    required this.controller,
    this.customValidator,
  });

  final TextEditingController controller;
  final String? Function(String?)? customValidator;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      controller: controller,
      textInputType: TextInputType.emailAddress,
      isPassword: false,
      labelTextString: emailLabelText,
      hintTextString: emailHintText,
      validator: customValidator ??
          (value) {
            if (value == null || value.isEmpty) {
              SnackBarManager.showErrorSnackBar(validatorEmailFormat);
              return null;
            }
            if (!isEmail(value)) {
              SnackBarManager.showErrorSnackBar(validatorEmailFormat);
              return null;
            }
            return null;
          },
    );
  }
}

class AuthPasswordField extends StatelessWidget {
  const AuthPasswordField({
    super.key,
    required this.controller,
    this.customValidator,
  });

  final TextEditingController controller;
  final String? Function(String?)? customValidator;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      controller: controller,
      textInputType: TextInputType.text,
      isPassword: true,
      labelTextString: passwordLabelText,
      hintTextString: passwordHintText,
      validator: customValidator ??
          (value) {
            if (value == null || value.isEmpty) {
              SnackBarManager.showErrorSnackBar(validatorEmailEmpty);
              return null;
            }
            return null;
          },
    );
  }
}

class AuthNameField extends StatelessWidget {
  const AuthNameField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      controller: controller,
      textInputType: TextInputType.text,
      isPassword: false,
      labelTextString: nameLabelText,
      hintTextString: nameHintText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          SnackBarManager.showErrorSnackBar(validatorNameEmpty);
          return null;
        }
        if (!isLength(value, 2, 30)) {
          SnackBarManager.showErrorSnackBar(validatorNameFormat);
          return null;
        }
        return null;
      },
    );
  }
}
