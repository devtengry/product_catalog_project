import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/app_theme.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize the ProviderContainer before checking the session
  final container = ProviderContainer();

  // Perform session check asynchronously after container is ready
  await container.read(authNotifierProvider.notifier).checkSession();

  runApp(
    ProviderScope(
      overrides: [
        // You can override providers here if necessary
      ],
      child: MyApp(), // Pass the container to MyApp
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: Size(390, 844),
      builder: (context, child) => MaterialApp.router(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerDelegate: router.delegate(),
        routeInformationParser: router.defaultRouteParser(),
      ),
    );
  }
}
