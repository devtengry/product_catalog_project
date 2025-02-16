import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/ui/screens/login_screen/login_screen_view.dart';
import 'package:product_catalog_project/ui/screens/splash_screen/splash_screen_view.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      builder: (context, child) => MaterialApp(
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: LoginScreenView(),
      ),
    );
  }
}
