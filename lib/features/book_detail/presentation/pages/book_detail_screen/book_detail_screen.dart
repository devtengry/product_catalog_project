import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/book_detail/presentation/pages/widgets/buy_button.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/widgets/app_bar/main_app_bar.dart';

@RoutePage()
class BookDetailScreen extends ConsumerWidget {
  const BookDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String bookPhotoAsset = AssetsPath().bookAssetPath;

    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      appBar: MainAppBar(
        suffixText: 'Book Details',
        leadingIcon: IconButton(
          onPressed: () => context.router.popForced(),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Center(
                        child: Column(
                          spacing: 40.h,
                          children: [
                            Column(
                              children: [
                                _BookImage(bookPhotoAsset: bookPhotoAsset),
                                _BookTitle(bookTitle: 'Dune'),
                                _BookAuthor(bookAuthor: 'Frank Herbert'),
                              ],
                            ),
                            _BookSummary(
                              summaryTitle: 'Summary',
                              bookSummary:
                                  'Dune is set in the distant future...',
                            ),
                            _BuyButton(
                              buttonText: 'Buy Now',
                              bookPrice: '87.75',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.h,
                      right: 0.w,
                      child: _LikeButton(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final likeButtonProvider = StateProvider<bool>((ref) => false);

class _LikeButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isClicked = ref.watch(likeButtonProvider);

    return Container(
      width: 44.w,
      height: 44.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ProjectColors.likeButtonContainer,
      ),
      child: IconButton(
        icon: Icon(
          isClicked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: ProjectColors.likeButtonHeart,
        ),
        onPressed: () =>
            ref.read(likeButtonProvider.notifier).state = !isClicked,
      ),
    );
  }
}

class _BuyButton extends ConsumerWidget {
  final String buttonText;
  final String bookPrice;

  const _BuyButton({
    required this.buttonText,
    required this.bookPrice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 350.w,
      height: 60.h,
      child: BuyButton(
        buttonText: buttonText,
        bookPrice: '$bookPrice \$',
        onPressed: () => router.push(HomeRoute()),
      ),
    );
  }
}

class _BookSummary extends ConsumerWidget {
  final String bookSummary;
  final String summaryTitle;

  const _BookSummary({
    required this.bookSummary,
    required this.summaryTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          summaryTitle,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: min(20.sp, 20),
                fontWeight: FontWeight.w700,
                color: ProjectColors.darkPurpleText,
              ),
        ),
        SizedBox(height: 10.h),
        Text(
          bookSummary,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: min(16.sp, 16),
                height: 1.6,
                fontWeight: FontWeight.w400,
                color: ProjectColors.darkPurpleText.withValues(alpha: 0.6),
              ),
        ),
      ],
    );
  }
}

class _BookAuthor extends ConsumerWidget {
  final String bookAuthor;

  const _BookAuthor({required this.bookAuthor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      bookAuthor,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(16.sp, 16),
            fontWeight: FontWeight.w600,
            color: ProjectColors.darkPurpleText.withValues(alpha: 0.6),
          ),
    );
  }
}

class _BookTitle extends ConsumerWidget {
  final String bookTitle;

  const _BookTitle({required this.bookTitle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      bookTitle,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(20.sp, 20),
            fontWeight: FontWeight.w700,
            color: ProjectColors.darkPurpleText,
          ),
    );
  }
}

class _BookImage extends ConsumerWidget {
  final String bookPhotoAsset;

  const _BookImage({required this.bookPhotoAsset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 150.w,
      height: 225.h,
      child: Image.asset(
        bookPhotoAsset,
        fit: BoxFit.contain,
      ),
    );
  }
}
