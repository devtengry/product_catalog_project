import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/auth/presentation/provider/auth_provider.dart';

void useLoadSavedCredentials(WidgetRef ref, TextEditingController email,
    TextEditingController password) {
  useEffect(() {
    Future.microtask(() async {
      final credentials = await AuthStorage.getCredentials();
      email.text = credentials['email'] ?? '';
      password.text = credentials['password'] ?? '';

      final remember = credentials['email']?.isNotEmpty == true &&
          credentials['password']?.isNotEmpty == true;

      ref.read(rememberMeProvider.notifier).state = remember;
    });
    return null;
  }, []);
}
