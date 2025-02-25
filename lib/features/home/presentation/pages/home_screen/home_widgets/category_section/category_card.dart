import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/router/app_router.dart';

class CategoryCard extends ConsumerWidget {
  const CategoryCard({
    super.key,
    required this.categoryName,
  });

  final String categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 350.w,
      height: 187.h,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CategoryHeader(categoryName: categoryName),
            const Expanded(
              child: _HorizontalBookList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookRow extends ConsumerWidget {
  const _BookRow();

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
                  _BookTitle(),
                  _BookAuthor(),
                ],
              ),
              _BookPrice(),
            ],
          ),
        ),
      ],
    );
  }
}

class _BookPrice extends StatelessWidget {
  const _BookPrice();

  @override
  Widget build(BuildContext context) {
    return Text(
      '87,75',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: ProjectColors.priceText),
    );
  }
}

class _BookAuthor extends StatelessWidget {
  const _BookAuthor();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Frank Herbert',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: ProjectColors.darkPurpleText.withValues(alpha: 0.6),
          ),
    );
  }
}

class _BookTitle extends StatelessWidget {
  const _BookTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Dune',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: ProjectColors.darkPurpleText,
          ),
    );
  }
}

class _BookCoverImage extends StatelessWidget {
  const _BookCoverImage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 120.h,
      child: Image.asset('assets/images/dune_book.png'),
    );
  }
}

class _CategoryHeader extends ConsumerWidget {
  const _CategoryHeader({
    required this.categoryName,
  });

  final String categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CategoryText(categoryName: categoryName),
        const _CategoryTextButton(),
      ],
    );
  }
}

class _CategoryTextButton extends ConsumerWidget {
  const _CategoryTextButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => router.push(CategoryDetailRoute()),
      child: Text(
        'View All',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: ProjectColors.orangeTextButton),
      ),
    );
  }
}

class _CategoryText extends ConsumerWidget {
  const _CategoryText({required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      categoryName,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ProjectColors.darkPurpleText,
          ),
    );
  }
}

class _HorizontalBookList extends ConsumerWidget {
  const _HorizontalBookList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
          (index) => const Padding(
            padding: EdgeInsets.only(right: 10),
            child: _ScrollableBookRow(),
          ),
        ),
      ),
    );
  }
}

class _ScrollableBookRow extends ConsumerWidget {
  const _ScrollableBookRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 210.h / 140.h,
      child: GestureDetector(
        onTap: () => router.push(BookDetailRoute()),
        child: Container(
          width: 210.w,
          constraints: BoxConstraints(minHeight: 140.h),
          child: Card(
            shadowColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: ProjectColors.cardBackground,
            child: const _BookRow(),
          ),
        ),
      ),
    );
  }
}
