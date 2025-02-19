import 'package:flutter/material.dart';
import 'package:product_catalog_project/ui/screens/auth_screens/login_screen/login_screen.dart';
import 'package:product_catalog_project/ui/screens/auth_screens/register_screen/register_screen.dart';
import 'package:product_catalog_project/ui/screens/auth_screens/splash_screen/splash_screen.dart';
import 'package:product_catalog_project/ui/screens/home_screen/home_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static Route<dynamic> generaeRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
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
