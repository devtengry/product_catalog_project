import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/app/my_app.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final container = ProviderContainer();

  await container.read(authServiceProvider.notifier).checkSession();

  runApp(
    ProviderScope(
      overrides: [],
      child: MyApp(),
    ),
  );
}
