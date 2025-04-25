import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/text_constants.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:product_catalog_project/features/book_detail/presentation/provider/like_providers.dart';

class LikeButton extends ConsumerWidget {
  final int productId;

  const LikeButton({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likeState = ref.watch(likeButtonProvider(productId));

    return Container(
      width: 44.w,
      height: 44.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kLikeButtonContainer,
      ),
      child: IconButton(
        icon: likeState.isLoading
            ? const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              )
            : Icon(
                likeState.isLiked
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: likeState.isLiked
                    ? kLikeButtonHeart
                    : kLikeButtonHeart.withValues(alpha: 0.6),
                size: 26,
              ),
        onPressed: likeState.isLoading
            ? null
            : () async {
                try {
                  await ref
                      .read(likeButtonProvider(productId).notifier)
                      .toggleLike();

                  final updated = ref.read(likeButtonProvider(productId));
                  final newLikeStatus = updated.isLiked;

                  SnackBarManager(context).showErrorSnackBar(
                    newLikeStatus ? likedText : unlikedText,
                  );
                } catch (e) {
                  SnackBarManager(context).showErrorSnackBar(anErrorText);
                }
              },
      ),
    );
  }
}
