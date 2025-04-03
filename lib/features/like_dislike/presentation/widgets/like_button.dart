import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';
import 'package:product_catalog_project/features/like_dislike/providers/like_providers.dart';

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
          isLiked ? Icons.favorite_border_rounded : Icons.favorite_rounded,
          color: ProjectColors.likeButtonHeart,
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

      final token = await AuthStorage.getToken();

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: ProjectColors.elevatedButton,
        ),
      );
    }
  }
}
