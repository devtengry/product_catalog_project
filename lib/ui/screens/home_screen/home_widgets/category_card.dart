import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/core/theme/text_style/text_styles.dart';

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
            const Expanded(child: HorizontalBookList()),
          ],
        ),
      ),
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
        CategoryText(categoryName: categoryName),
        const CategoryTextButton(),
      ],
    );
  }
}

class HorizontalBookList extends ConsumerWidget {
  const HorizontalBookList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
          (index) => const Padding(
            padding: EdgeInsets.only(right: 10),
            child: ScrollableBookRow(),
          ),
        ),
      ),
    );
  }
}

class ScrollableBookRow extends ConsumerWidget {
  const ScrollableBookRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 210.w,
      constraints: BoxConstraints(minHeight: 140.h),
      child: Card(
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: ProjectColors.cardBackground,
        child: const BookRow(),
      ),
    );
  }
}

class BookRow extends ConsumerWidget {
  const BookRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        SizedBox(
          width: 80.w,
          height: 120.h,
          child: Image.asset('assets/images/dune_book.png'),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dune', style: TextStyles.bookTitle12SemiBold(context)),
                  Text('Frank Herbert', style: TextStyles.authorStyle(context)),
                ],
              ),
              Text('87,75', style: TextStyles.priceStyle(context)),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryTextButton extends ConsumerWidget {
  const CategoryTextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {},
      child: Text(
        'View All',
        style: TextStyles.textButton12SemiBold(context),
      ),
    );
  }
}

class CategoryText extends ConsumerWidget {
  const CategoryText({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(categoryName, style: TextStyles.bold20Header(context));
  }
}
