import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/book_detail/repos/like_repository.dart';
import 'package:product_catalog_project/features/book_detail/states/like_state.dart';
import 'package:product_catalog_project/features/home/presentation/provider/product_provider.dart';
import 'like_button_notifier.dart';

final likeRepositoryProvider = Provider((ref) => LikeRepository());

final likeButtonProvider =
    StateNotifierProvider.family<LikeButtonNotifier, LikeState, int>(
  (ref, productId) {
    final isInitiallyLiked = ref.watch(productLikesProvider(productId));
    return LikeButtonNotifier(
      ref.watch(likeRepositoryProvider),
      productId,
      isInitiallyLiked,
    );
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
