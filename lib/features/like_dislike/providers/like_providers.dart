import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/like_dislike/providers/like_button_notifier.dart';
import 'package:product_catalog_project/features/like_dislike/repos/like_repository.dart';

final likeRepositoryProvider = Provider((ref) => LikeRepository());

final likeButtonProvider =
    StateNotifierProvider.family<LikeButtonNotifier, bool, int>(
  (ref, productId) => LikeButtonNotifier(
    ref.watch(likeRepositoryProvider),
    productId,
    false,
  ),
);
