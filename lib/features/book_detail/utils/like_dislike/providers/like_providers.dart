import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/home/presentation/provider/product_provider.dart';
import 'package:product_catalog_project/features/book_detail/utils/like_dislike/providers/like_button_notifier.dart';
import 'package:product_catalog_project/features/book_detail/utils/like_dislike/repos/like_repository.dart';

final likeRepositoryProvider = Provider((ref) => LikeRepository());

final likeButtonProvider =
    StateNotifierProvider.family<LikeButtonNotifier, bool, int>(
  (ref, productId) {
    final initialState = ref.watch(productLikesProvider(productId));
    return LikeButtonNotifier(
        ref.watch(likeRepositoryProvider), productId, initialState);
  },
);

final productLikesProvider = Provider.family<bool, int>((ref, productId) {
  final allProductsAsync = ref.watch(allProductsProvider);

  return allProductsAsync.maybeWhen(
    data: (products) {
      final product = products.firstWhere(
        (p) => p.id == productId,
        orElse: () => throw Exception('Product not found'),
      );
      return product.likes == 1;
    },
    orElse: () => false,
  );
});
