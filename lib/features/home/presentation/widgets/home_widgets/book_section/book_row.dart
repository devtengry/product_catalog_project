import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/home/data/models/product_model.dart';

class BookRow extends ConsumerWidget {
  const BookRow({super.key, required this.product});

  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        _BookCoverImage(
          coverUrl: product.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BookTitle(
                    bookTitle: product.name,
                  ),
                  _BookAuthor(
                    bookAuthor: product.author,
                  ),
                ],
              ),
              _BookPrice(
                bookPrice: product.price.toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BookPrice extends ConsumerWidget {
  final String bookPrice;

  const _BookPrice({required this.bookPrice});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      '$bookPrice \$',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: ProjectColors.priceText),
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
            fontSize: 10,
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
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: ProjectColors.darkPurpleText,
          ),
    );
  }
}

class _BookCoverImage extends ConsumerWidget {
  const _BookCoverImage({required this.coverUrl});
  final String coverUrl;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 80.w,
      height: 120.h,
      child: Image.network(
        coverUrl,
        errorBuilder: (_, __, ___) => const Icon(Icons.error),
      ),
    );
  }
}
