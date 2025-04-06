import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/home/data/models/product_model.dart';
import 'package:product_catalog_project/features/home/data/services/products_service.dart';

final productsServiceProvider = Provider((ref) => ProductsService());

final categoryProductsProvider =
    FutureProvider.family<List<Product>, int>((ref, categoryId) async {
  final service = ref.read(productsServiceProvider);
  try {
    final products = await service.fetchProductsByCategory(categoryId);
    return products.map((json) => Product.fromJson(json)).toList();
  } catch (e) {
    throw "Failed to load products. Please try again.";
  }
});

final allProductsProvider = FutureProvider<List<Product>>((ref) async {
  final service = ref.read(productsServiceProvider);
  final List<Product> allProducts = [];

  try {
    for (int categoryId = 1; categoryId <= 4; categoryId++) {
      final products = await service.fetchProductsByCategory(categoryId);
      allProducts.addAll(products.map((json) => Product.fromJson(json)));
    }
    return allProducts;
  } catch (e) {
    throw "Failed to load all products. Please try again.";
  }
});

final coverImageProvider =
    FutureProvider.family<String, String>((ref, fileName) async {
  final service = ref.read(productsServiceProvider);
  try {
    return await service.fetchCoverImage(fileName);
  } catch (e) {
    throw "Failed to load cover image.";
  }
});
