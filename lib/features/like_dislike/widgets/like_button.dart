import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/app_constants.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/like_dislike/providers/like_providers.dart';
import 'package:product_catalog_project/utils/shared_preferences_helper.dart';

final likeButtonProvider =
    StateProvider.family<bool, int>((ref, productId) => false);

class LikeButton extends ConsumerWidget {
  final int productId;
  final double size;

  const LikeButton({
    super.key,
    required this.productId,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLiked = ref.watch(likeButtonProvider(productId));

    return Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ProjectColors.likeButtonContainer,
      ),
      child: IconButton(
        icon: Icon(
          isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: isLiked
              ? ProjectColors.likeButtonHeart
              : ProjectColors.likeButtonHeart,
          size: size * 0.6,
        ),
        onPressed: () => _handleLike(ref, context),
      ),
    );
  }

  Future<void> _handleLike(WidgetRef ref, BuildContext context) async {
    final notifier = ref.read(likeButtonProvider(productId).notifier);
    final currentState = notifier.state;

    try {
      notifier.state = !currentState;

      final prefs = await getSharedPreferences();
      final token = prefs.getString(AppConstants.tokenKey);

      if (token == null) {
        throw Exception('Please login first!');
      }

      await ref.read(likeRepositoryProvider).toggleLike(
            productId,
            token,
            !currentState,
          );
    } catch (e) {
      notifier.state = currentState;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: ProjectColors.elevatedButton,
        ),
      );
    }
  }
}
