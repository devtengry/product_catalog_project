import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/like_dislike/repos/like_repository.dart';
import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';

class LikeButtonNotifier extends StateNotifier<bool> {
  final LikeRepository _repository;
  final int productId;

  LikeButtonNotifier(this._repository, this.productId, bool initialState)
      : super(initialState);

  Future<void> toggleLike() async {
    final token = await AuthStorage.getToken();
    if (token == null) {
      throw Exception('Please login first!');
    }

    final bool currentState = state;

    try {
      await _repository.toggleLike(productId, token, !currentState);

      state = !currentState;
    } on Exception catch (e) {
      final errorMessage = e.toString();

      if (errorMessage.contains('duplicate key')) {
        await _repository.toggleLike(productId, token, false);
        state = false;
        return;
      }

      throw Exception('Failed to update like status: $errorMessage');
    }
  }
}
