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

class RegisterScreenView extends ConsumerStatefulWidget {
  const RegisterScreenView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterScreenViewState();
}

class _RegisterScreenViewState extends ConsumerState<RegisterScreenView> {
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
                        TextConstants.welcomeText,
                        style: TextStyles.semiBoldHeader(context),
                      ),
                      Text(
                        TextConstants.registerAnAccountText,
                        style: TextStyles.bold20Header(context),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  AuthTextField(
                    hintTextString: TextConstants.nameHintText,
                    labelTextString: TextConstants.nameLabelText,
                    isPassword: false,
                  ),
                  AuthTextField(
                    hintTextString: TextConstants.emailHintText,
                    labelTextString: TextConstants.emailLabelText,
                    isPassword: false,
                  ),
                  Column(
                    children: [
                      AuthTextField(
                        hintTextString: TextConstants.passwordHintText,
                        labelTextString: TextConstants.passwordLabelText,
                        isPassword: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AuthTextButton(
                              onPressed: () => Navigator.pushNamed(
                                    context,
                                    AppRouter.login,
                                  ),
                              buttonText: TextConstants.loginText),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 350.w,
                    height: 60.h,
                    child: ElevatedLoginButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRouter.register),
                      buttonText: TextConstants.authButtonTextRegisterText,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
