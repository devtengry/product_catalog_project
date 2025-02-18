import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/localizations/text_constants.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/core/theme/text_style/text_styles.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/widgets/auth_text_button.dart';
import 'package:product_catalog_project/ui/widgets/auth_text_field.dart';
import 'package:product_catalog_project/ui/widgets/login_button.dart';
import 'package:product_catalog_project/ui/widgets/remember_me_checkbox.dart';

final rememberMeProvider = StateProvider<bool>((ref) => false);

class LoginScreenView extends ConsumerStatefulWidget {
  const LoginScreenView({super.key});

  @override
  _LoginScreenViewState createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends ConsumerState<LoginScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 350.w,
                height: 60.h,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              SizedBox(
                height: 115.h,
              ),
              Column(
                spacing: 24,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(
                    height: 80.h,
                  ),
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
                                    context,
                                    AppRouter.register,
                                  ),
                              buttonText: TextConstants.registerText)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                children: [
                  SizedBox(
                      width: 350.w,
                      height: 60.h,
                      child: ElevatedLoginButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRouter.login),
                        buttonText: TextConstants.authButtonTextLoginText,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
