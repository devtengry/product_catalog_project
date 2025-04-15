import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:product_catalog_project/features/home/presentation/provider/product_provider.dart';
import 'package:product_catalog_project/router/app_router.dart';

class HomeSearchBar extends ConsumerWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = TextEditingController();
    return Flexible(
      flex: 0,
      fit: FlexFit.tight,
      child: _SearchField(
        controller: searchController,
        textInputType: TextInputType.text,
      ),
    );
  }
}

class _SearchField extends ConsumerWidget {
  final TextInputType textInputType;
  final TextEditingController controller;

  const _SearchField({
    required this.controller,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      keyboardType: textInputType,
      controller: controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        filled: true,
        fillColor: ProjectColors.textFieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const _SearchIcons(icon: Icons.search),
        hintText: 'Search',
        hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: min(16.sp, 16),
              fontWeight: FontWeight.w400,
              color: ProjectColors.darkPurpleText.withAlpha(102),
            ),
        suffixIcon: const _SearchIcons(icon: Icons.tune),
      ),
      onSubmitted: (value) async {
        await _handleSearch(context, ref, value);
      },
    );
  }

  Future<void> _handleSearch(
      BuildContext context, WidgetRef ref, String query) async {
    if (query.trim().isEmpty) {
      SnackBarManager(context)
          .showErrorSnackBar('Please enter a product name first.');
      return;
    }
    final productsAsync = await ref.read(allProductsProvider.future);
    final filteredProducts = productsAsync
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.author.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredProducts.isNotEmpty) {
      final firstProduct = filteredProducts.first;
      context.router.push(BookDetailRoute(productId: firstProduct.id));
    } else {
      SnackBarManager(context).showErrorSnackBar('No matching products found.');
    }
  }
}

class _SearchIcons extends ConsumerWidget {
  const _SearchIcons({
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Icon(
      icon,
      color: ProjectColors.iconColor.withAlpha(102),
    );
  }
}
