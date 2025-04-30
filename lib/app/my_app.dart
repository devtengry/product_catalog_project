import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/app_theme.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/utils/keys.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: Size(390, 844),
      builder: (context, child) => MaterialApp.router(
        theme: AppTheme.lightTheme,
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        routerDelegate: router.delegate(),
        routeInformationParser: router.defaultRouteParser(),
      ),
    );
  }
}
