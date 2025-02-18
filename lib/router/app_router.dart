import 'package:flutter/material.dart';
import 'package:product_catalog_project/ui/screens/login_screen/login_screen_view.dart';
import 'package:product_catalog_project/ui/screens/register_screen/register_screen_view.dart';
import 'package:product_catalog_project/ui/screens/splash_screen/splash_screen_view.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic> generaeRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreenView());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreenView());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreenView());
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
