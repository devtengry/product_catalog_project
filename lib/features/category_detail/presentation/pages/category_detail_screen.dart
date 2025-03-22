import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/home/data/models/product_model.dart';
import 'package:product_catalog_project/features/home/presentation/provider/product_provider.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/widgets/app_bar/main_app_bar.dart';
import 'package:product_catalog_project/ui/widgets/search_bar/search_bar.dart';

@RoutePage()
class CategoryDetailScreen extends ConsumerWidget {
  final int categoryId;

  const CategoryDetailScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(categoryProductsProvider(categoryId));

    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      appBar: MainAppBar(
        suffixText: 'Best Seller',
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              HomeSearchBar(),
              Expanded(
                child: productAsync.when(
                  error: (error, _) => Center(child: Text('Error: $error')),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  data: (products) => GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 170.w / 284.h,
                    ),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: _CategoryDetailBook(product: products[index]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryDetailBook extends ConsumerWidget {
  final Product product;

  const _CategoryDetailBook({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => router.push(BookDetailRoute(productId: product.id)),
      child: Container(
        width: 170.w,
        height: 284.h,
        decoration: BoxDecoration(
          color: ProjectColors.cardBackground,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Flexible(
                child: AspectRatio(
                  aspectRatio: 150.h / 225.w,
                  child: _BookCoverImage(fileName: product.cover),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TitleText(bookTitle: product.name),
                      _AuthorText(bookAuthor: product.author),
                    ],
                  ),
                  _PriceText(bookPrice: product.price.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookCoverImage extends ConsumerWidget {
  final String fileName;

  const _BookCoverImage({required this.fileName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverUrl = ref.watch(coverImageProvider(fileName));

    return SizedBox(
      width: min(150.w, 150),
      height: min(225.h, 225),
      child: AspectRatio(
        aspectRatio: 120.h / 80.w,
        child: coverUrl.when(
          data: (url) => Image.network(
            url,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Icon(Icons.error),
        ),
      ),
    );
  }
}

class _TitleText extends ConsumerWidget {
  final String bookTitle;

  const _TitleText({required this.bookTitle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      bookTitle,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(10.sp, 10),
            fontWeight: FontWeight.w600,
            color: ProjectColors.darkPurpleText,
          ),
    );
  }
}

class _AuthorText extends ConsumerWidget {
  final String bookAuthor;

  const _AuthorText({
    required this.bookAuthor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      bookAuthor,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(8.sp, 8),
            fontWeight: FontWeight.w700,
            color: ProjectColors.darkPurpleText.withValues(alpha: 0.6),
          ),
    );
  }
}

class _PriceText extends ConsumerWidget {
  final String bookPrice;

  const _PriceText({
    required this.bookPrice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      '$bookPrice \$',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(12.sp, 12),
            fontWeight: FontWeight.w700,
            color: ProjectColors.priceText,
          ),
    );
  }
}
