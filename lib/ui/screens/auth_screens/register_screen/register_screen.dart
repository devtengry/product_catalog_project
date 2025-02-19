import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/core/theme/text_style/text_styles.dart';
import 'package:product_catalog_project/ui/widgets/auth_widgets/auth_text_button.dart';
import 'package:product_catalog_project/ui/widgets/auth_widgets/auth_text_field.dart';
import 'package:product_catalog_project/ui/widgets/auth_widgets/auth_elevated_button.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final String _logoAssetPath = AssetsPath().logoAssetPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                SizedBox(
                  width: 350.w,
                  height: 60.h,
                  child: Image.asset(_logoAssetPath),
                ),
                Spacer(),
                Row(
                  children: [
                    Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextConstants.welcomeText,
                          style: TextStyles.semiBoldHeader(context),
                        ),
                        Text(
                          TextConstants.registerAnAccountText,
                          style: TextStyles.bold20Header(context),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                AuthTextField(
                  hintTextString: TextConstants.nameHintText,
                  labelTextString: TextConstants.nameLabelText,
                  isPassword: false,
                ),
                SizedBox(height: 24.h),
                AuthTextField(
                  hintTextString: TextConstants.emailHintText,
                  labelTextString: TextConstants.emailLabelText,
                  isPassword: false,
                ),
                SizedBox(height: 24.h),
                AuthTextField(
                  hintTextString: TextConstants.passwordHintText,
                  labelTextString: TextConstants.passwordLabelText,
                  isPassword: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AuthTextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRouter.login),
                      buttonText: TextConstants.loginText,
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: 350.w,
                  height: 60.h,
                  child: AuthElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRouter.register),
                    buttonText: TextConstants.authButtonTextRegisterText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
