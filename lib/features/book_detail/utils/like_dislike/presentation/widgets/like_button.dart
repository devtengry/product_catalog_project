import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:product_catalog_project/features/book_detail/utils/like_dislike/providers/like_providers.dart';

class LikeButton extends ConsumerWidget {
  final int productId;

  const LikeButton({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLiked = ref.watch(likeButtonProvider(productId));

    return Container(
      width: 44.w,
      height: 44.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ProjectColors.likeButtonContainer,
      ),
      child: IconButton(
        icon: Icon(
          isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: isLiked
              ? ProjectColors.likeButtonHeart
              : ProjectColors.likeButtonHeart.withValues(alpha: 0.6),
          size: 26,
        ),
        onPressed: () async {
          try {
            await ref.read(likeButtonProvider(productId).notifier).toggleLike();

            final newLikeStatus = !isLiked;

            SnackBarManager(context).showErrorSnackBar(
              newLikeStatus ? 'Product liked.' : 'Product unliked.',
            );
          } catch (e) {
            SnackBarManager(context).showErrorSnackBar('Error occurred.');
          }
        },
      ),
    );
  }
}
