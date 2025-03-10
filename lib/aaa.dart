import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/home/data/models/product_model.dart';
import 'package:product_catalog_project/features/home/data/services/products_service.dart';

// DioService Provider
final productServiceProvider = Provider((ref) => ProductsService());

// Ürünleri Getir Provider
final productRepositoryProvider = Provider((ref) {
  final dioService = ref.read(productServiceProvider);
  return ProductRepository(dioService);
});

class ProductRepository {
  final ProductsService productServiceProvider;

  ProductRepository(this.productServiceProvider);

  // Tüm kategorilerdeki ürünleri çek
  Future<List<Product>> fetchAllProducts() async {
    final List<Product> allProducts = [];
    for (int categoryId = 1; categoryId <= 4; categoryId++) {
      final products =
          await productServiceProvider.fetchProductsByCategory(categoryId);
      allProducts.addAll(
        products.map((json) => Product.fromJson(json)).toList(),
      );
    }
    return allProducts;
  }
}

// Ürün State'i
final productListProvider =
    StateNotifierProvider<ProductNotifier, AsyncValue<List<Product>>>((ref) {
  return ProductNotifier(ref);
});

class ProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final Ref ref;

  ProductNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    state = const AsyncValue.loading();
    try {
      final products =
          await ref.read(productRepositoryProvider).fetchAllProducts();
      state = AsyncValue.data(products);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
