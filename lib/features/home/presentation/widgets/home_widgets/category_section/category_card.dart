import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';
import 'package:product_catalog_project/features/home/data/models/category_model.dart';
import 'package:product_catalog_project/features/home/presentation/widgets/home_widgets/book_section/horizontal_book_list.dart';
import 'package:product_catalog_project/router/app_router.dart';

class CategoryCard extends ConsumerWidget {
  const CategoryCard({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 350.w,
      height: 187.h,
      child: _CategoryCard(category: category),
    );
  }
}

class _CategoryCard extends ConsumerWidget {
  final Category category;

  const _CategoryCard({
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CategoryHeader(category: category),
          Expanded(
            child: HorizontalBookList(categoryId: category.id!),
          ),
        ],
      ),
    );
  }
}

class _CategoryHeader extends ConsumerWidget {
  const _CategoryHeader({
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CategoryText(category: category),
        _CategoryTextButton(categoryId: category.id!),
      ],
    );
  }
}

class _CategoryText extends ConsumerWidget {
  const _CategoryText({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      category.name ?? 'No Data',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(20.sp, 20),
            fontWeight: FontWeight.w600,
            color: kDarkPurpleText,
          ),
    );
  }
}

class _CategoryTextButton extends ConsumerWidget {
  final int categoryId;

  const _CategoryTextButton({required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: TextButton(
        onPressed: () =>
            router.push(CategoryDetailRoute(categoryId: categoryId)),
        child: Text(
          'View All',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: min(12.sp, 12),
              fontWeight: FontWeight.w600,
              color: kOrangeTextButton),
        ),
      ),
    );
  }
}
