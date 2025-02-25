import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/router/.app_router.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/login_screen/login_screen.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/register_screen/register_screen.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/splash_screen/splash_screen.dart';
import 'package:product_catalog_project/features/book_detail/presentation/pages/book_detail_screen/book_detail_screen.dart';
import 'package:product_catalog_project/features/category_detail/presentation/pages/category_detail_screen/category_detail.dart';
import 'package:product_catalog_project/features/home/presentation/pages/home_screen/home_screen.dart';
import 'package:product_catalog_project/router/app_router.dart';

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
      builder: (context, child) => MaterialApp.router(
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        routerDelegate: router.delegate(),
        routeInformationParser: router.defaultRouteParser(),
      ),
    );
  }
}
