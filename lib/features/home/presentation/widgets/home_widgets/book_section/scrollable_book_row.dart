import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/features/home/data/models/product_model.dart';
import 'package:product_catalog_project/features/home/presentation/widgets/home_widgets/book_section/book_row.dart';
import 'package:product_catalog_project/router/app_router.dart';

class ScrollableBookRow extends ConsumerWidget {
  final Product product;
  const ScrollableBookRow({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 210.w,
      height: 140.h,
      child: GestureDetector(
        onTap: () => router.push(BookDetailRoute()),
        child: Container(
          width: 210.w,
          constraints: BoxConstraints(minHeight: 140.h),
          child: Card(
            child: BookRow(product: product),
          ),
        ),
      ),
    );
  }
}
