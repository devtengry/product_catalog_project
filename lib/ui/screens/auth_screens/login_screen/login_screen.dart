import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/core/theme/text_style/text_styles.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/widgets/auth_widgets/auth_text_button.dart';
import 'package:product_catalog_project/ui/widgets/auth_widgets/auth_text_field.dart';
import 'package:product_catalog_project/ui/widgets/auth_widgets/auth_elevated_button.dart';
import 'package:product_catalog_project/ui/widgets/auth_widgets/remember_me_checkbox.dart';

final rememberMeProvider = StateProvider<bool>((ref) => false);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextConstants.welcomeBackText,
                          style: TextStyles.semiBoldHeader(context),
                        ),
                        Text(
                          TextConstants.loginToYourAccountText,
                          style: TextStyles.bold20Header(context),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  spacing: 24,
                  children: [
                    const AuthTextField(
                      isPassword: false,
                      labelTextString: TextConstants.emailLabelText,
                      hintTextString: TextConstants.emailHintText,
                    ),
                    Column(
                      children: [
                        const AuthTextField(
                          isPassword: true,
                          labelTextString: TextConstants.passwordLabelText,
                          hintTextString: TextConstants.passwordHintText,
                        ),
                        Row(
                          children: [
                            RememberMeCheckbox(),
                            const Spacer(),
                            AuthTextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, AppRouter.register),
                              buttonText: TextConstants.registerText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 350.w,
                  height: 60.h,
                  child: AuthElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRouter.home),
                    buttonText: TextConstants.authButtonTextLoginText,
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
