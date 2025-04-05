import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_elevated_button.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_text_button.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:validators2/validators2.dart';

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
                    color: ProjectColors.darkPurpleText.withAlpha(150),
                  ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: min(20.sp, 20),
                    fontWeight: FontWeight.w700,
                    color: ProjectColors.darkPurpleText,
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
      labelTextString: TextConstants.emailLabelText,
      hintTextString: TextConstants.emailHintText,
      validator: customValidator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'E-Mail cannot be empty!';
            }
            if (!isEmail(value)) {
              return 'Please enter a valid e-mail!';
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
      labelTextString: TextConstants.passwordLabelText,
      hintTextString: TextConstants.passwordHintText,
      validator: customValidator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Password cannot be empty!';
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
      labelTextString: TextConstants.nameLabelText,
      hintTextString: TextConstants.nameHintText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name cannot be empty!';
        }
        if (!isLength(value, 2, 50)) {
          return 'Name must be between 2 and 50 characters!';
        }
        return null;
      },
    );
  }
}
