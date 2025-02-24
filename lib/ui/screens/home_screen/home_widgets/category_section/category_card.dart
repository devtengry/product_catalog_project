import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/ui/screens/home_screen/home_widgets/category_section/category_header.dart';
import 'package:product_catalog_project/ui/screens/home_screen/home_widgets/category_section/horizontal_book_list.dart';

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
            CategoryHeader(categoryName: categoryName),
            const Expanded(child: HorizontalBookList()),
          ],
        ),
      ),
    );
  }
}
