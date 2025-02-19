import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/screens/auth_screens/login_screen/login_screen.dart';
import 'package:product_catalog_project/ui/screens/auth_screens/register_screen/register_screen.dart';
import 'package:product_catalog_project/ui/screens/auth_screens/splash_screen/splash_screen.dart';
import 'package:product_catalog_project/ui/screens/home_screen/home_screen.dart';

void main(List<String> args) {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: Size(390, 844),
      builder: (context, child) => MaterialApp(
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generaeRoute,
        initialRoute: AppRouter.splash,
        home: LoginScreen(),
      ),
    );
  }
}
