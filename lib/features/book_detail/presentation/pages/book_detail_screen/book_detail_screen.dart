import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/book_detail/presentation/pages/widgets/buy_button.dart';
import 'package:product_catalog_project/features/book_detail/presentation/provider/product_detail_provider.dart';
import 'package:product_catalog_project/features/like_dislike/presentation/widgets/like_button.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/widgets/app_bar/main_app_bar.dart';
import 'package:product_catalog_project/ui/widgets/product_widgets/product_widgets.dart';

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
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: productDetailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
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
                            children: [
                              Column(
                                children: [
                                  ProductCoverImage(
                                      fileName: product.cover ?? ''),
                                  SizedBox(height: 16.h),
                                  ProductNameText(
                                    title: product.name ?? '',
                                    fontSize: min(20.sp, 20),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  ProductAuthorText(
                                    author: product.author ?? '',
                                    fontSize: min(16.sp, 16),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.h),
                              _BookSummary(
                                summaryTitle: 'Summary',
                                bookSummary: product.description ??
                                    'No description available.',
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
      bottomNavigationBar: productDetailAsync.maybeWhen(
        data: (productDetail) {
          final product = productDetail.productByPk;
          if (product == null) return const SizedBox.shrink();

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            child: SizedBox(
              width: min(350.w, 350),
              height: min(60.h, 60),
              child: BuyButton(
                buttonText: 'Buy Now',
                bookPrice: product.price?.toStringAsFixed(2) ?? '0.00',
                onPressed: () => router.push(HomeRoute()),
              ),
            ),
          );
        },
        orElse: () => const SizedBox.shrink(),
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
