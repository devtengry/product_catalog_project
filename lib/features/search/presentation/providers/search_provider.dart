import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/home/data/models/product_model.dart';
import 'package:product_catalog_project/features/home/presentation/provider/product_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final productsAsync = ref.watch(allProductsProvider);

  return productsAsync.when(
    data: (products) {
      if (query.isEmpty) return products;

      return products.where((product) {
        return product.name.toLowerCase().contains(query) ||
            product.author.toLowerCase().contains(query);
      }).toList();
    },
    loading: () => [],
    error: (e, _) => [],
  );
});
final searchControllerProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
);
