import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/book_detail/data/model/product_detail_model.dart';
import 'package:product_catalog_project/features/book_detail/repos/product_detail_repository.dart';

final productDetailProvider =
    FutureProvider.family<ProductDetailModel, int>((ref, productId) async {
  final repository = ref.watch(productDetailRepositoryProvider);
  return repository.fetchProductDetail(productId);
});
