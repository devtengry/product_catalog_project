import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_catalog_project/features/home/data/models/product_model.dart';
import 'package:product_catalog_project/features/home/presentation/provider/product_provider.dart';
import 'package:product_catalog_project/common/search_action/providers/search_provider.dart';

Future<List<Product>> useFilteredProductsAsync(WidgetRef ref) async {
  final query = ref.read(searchQueryProvider).toLowerCase();
  final productsAsync = await ref.read(allProductsProvider.future);

  if (query.isEmpty) return productsAsync;

  return productsAsync
      .where((product) =>
          product.name.toLowerCase().contains(query) ||
          product.author.toLowerCase().contains(query))
      .toList();
}
