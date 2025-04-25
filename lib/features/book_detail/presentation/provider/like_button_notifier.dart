import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/constants/text_constants.dart';
import 'package:product_catalog_project/features/book_detail/repos/like_repository.dart';
import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';
import 'package:product_catalog_project/features/book_detail/states/like_state.dart';

class LikeButtonNotifier extends StateNotifier<LikeState> {
  final LikeRepository _repository;
  final int productId;

  LikeButtonNotifier(this._repository, this.productId, bool isInitiallyLiked)
      : super(LikeState(isLiked: isInitiallyLiked));

  Future<void> toggleLike() async {
    final token = await AuthStorage.getToken();
    if (token == null) {
      state = state.copyWith(errorMessage: loginFirstText);
      return;
    }

    final currentLiked = state.isLiked;
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _repository.toggleLike(productId, token, !currentLiked);
      state = state.copyWith(isLiked: !currentLiked, isLoading: false);
    } on Exception catch (e) {
      final errorMessage = e.toString();

      if (errorMessage.contains('duplicate key')) {
        await _repository.toggleLike(productId, token, false);
        state = state.copyWith(isLiked: false, isLoading: false);
        return;
      }

      state = state.copyWith(
        isLoading: false,
        errorMessage: '$likeUpdateFailText: $errorMessage',
      );
    }
  }
}
