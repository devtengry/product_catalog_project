import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/book_detail/presentation/pages/widgets/buy_button.dart';
import 'package:product_catalog_project/features/book_detail/presentation/provider/product_detail_provider.dart';
import 'package:product_catalog_project/features/home/presentation/provider/product_provider.dart';
import 'package:product_catalog_project/features/like_dislike/widgets/like_button.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/widgets/app_bar/main_app_bar.dart';

@RoutePage()
class BookDetailScreen extends ConsumerWidget {
  final int productId;

  const BookDetailScreen({
    super.key,
    @PathParam('productId') required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetailAsync = ref.watch(productDetailProvider(productId));

    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      appBar: MainAppBar(
        suffixText: 'Book Details',
        leadingIcon: IconButton(
          onPressed: () => context.router.popForced(),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: productDetailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Error: $error')), // Hata durumunu göster
        data: (productDetail) {
          final product = productDetail.productByPk;

          if (product == null) {
            return const Center(child: Text('Product not found.'));
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
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
                                  _BookImage(fileName: product.cover ?? ''),
                                  _BookTitle(bookTitle: product.name ?? ''),
                                  _BookAuthor(bookAuthor: product.author ?? ''),
                                ],
                              ),
                              _BookSummary(
                                summaryTitle: 'Summary',
                                bookSummary: product.description ??
                                    'No description available.',
                              ),
                              _BuyButton(
                                buttonText: 'Buy Now',
                                bookPrice:
                                    product.price?.toStringAsFixed(2) ?? '0.00',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.h,
                        right: 0.w,
                        child: LikeButton(
                          productId: productId,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BookImage extends ConsumerWidget {
  final String fileName;

  const _BookImage({required this.fileName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverUrl = ref.watch(coverImageProvider(fileName));

    return SizedBox(
      width: 150.w,
      height: 225.h,
      child: coverUrl.when(
        data: (url) => Image.network(
          url,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const Icon(Icons.error),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Icon(Icons.error),
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
