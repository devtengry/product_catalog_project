import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/home/data/models/cover_image_response.dart';
import 'package:product_catalog_project/features/home/data/models/product_model.dart';
import 'package:product_catalog_project/features/home/data/services/products_service.dart';

final productsServiceProvider = Provider((ref) => ProductsService());

final categoryProductsProvider =
    FutureProvider.family<List<Product>, int>((ref, categoryId) async {
  final service = ref.read(productsServiceProvider);
  final products = await service.fetchProductsByCategory(categoryId);
  return products.map((json) => Product.fromJson(json)).toList();
});

final allProductsProvider = FutureProvider<List<Product>>((ref) async {
  final service = ref.read(productsServiceProvider);
  final List<Product> allProducts = [];

  for (int categoryId = 1; categoryId <= 4; categoryId++) {
    final products = await service.fetchProductsByCategory(categoryId);
    allProducts.addAll(products.map((json) => Product.fromJson(json)));
  }

  return allProducts;
});

final coverImageProvider = FutureProvider<CoverImageResponse>((ref) async {
  final service = ref.read(productsServiceProvider); // Service instance'ını al
  return service.fetchImage(); // Service üzerinden metodu çağır
});
