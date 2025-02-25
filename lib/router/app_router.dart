import 'package:flutter/material.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/login_screen/login_screen.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/register_screen/register_screen.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/splash_screen/splash_screen.dart';
import 'package:product_catalog_project/features/book_detail/presentation/pages/book_detail_screen/book_detail_screen.dart';
import 'package:product_catalog_project/features/category_detail/presentation/pages/category_detail_screen/category_detail.dart';
import 'package:product_catalog_project/features/home/presentation/pages/home_screen/home_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String categoryDetail = '/categoryDetail';
  static const String bookDetail = '/bookDetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case categoryDetail:
        return MaterialPageRoute(builder: (_) => CategoryDetail());
      case bookDetail:
        return MaterialPageRoute(builder: (_) => BookDetailScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
