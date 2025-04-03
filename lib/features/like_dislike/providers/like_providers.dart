import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/like_dislike/repos/like_repository.dart';

final likeRepositoryProvider = Provider((ref) => LikeRepository());
final likeButtonProvider =
    StateProvider.family<bool, int>((ref, productId) => false);
