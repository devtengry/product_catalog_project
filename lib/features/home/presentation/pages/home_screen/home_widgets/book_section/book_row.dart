import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

class BookRow extends ConsumerWidget {
  const BookRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        _BookCoverImage(),
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
                    bookTitle: 'Dune',
                  ),
                  _BookAuthor(
                    bookAuthor: 'Frank Herbert',
                  ),
                ],
              ),
              _BookPrice(
                bookPrice: '87.75',
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
  const _BookCoverImage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 80.w,
      height: 120.h,
      child: Image.asset('assets/images/dune_book.png'),
    );
  }
}
