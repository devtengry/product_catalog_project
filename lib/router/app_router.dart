import 'package:auto_route/auto_route.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/login_screen.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/register_screen.dart';
import 'package:product_catalog_project/features/auth/presentation/pages/auth_screens/splash_screen.dart';
import 'package:product_catalog_project/features/book_detail/presentation/pages/book_detail_screen/book_detail_screen.dart';
import 'package:product_catalog_project/features/category_detail/presentation/pages/category_detail_screen.dart';
import 'package:product_catalog_project/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: false, path: '/'),
        AutoRoute(page: LoginRoute.page, initial: true, path: '/login'),
        AutoRoute(page: RegisterRoute.page, initial: false, path: '/register'),
        AutoRoute(page: HomeRoute.page, initial: false, path: '/home'),
        AutoRoute(
            page: CategoryDetailRoute.page,
            initial: false,
            path: '/categoryDetail'),
        AutoRoute(page: BookDetailRoute.page, path: '/bookDetail/:productId'),
      ];
}

final router = AppRouter();
