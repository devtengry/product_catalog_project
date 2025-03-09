import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/features/home/presentation/pages/home_screen/home_widgets/book_section/book_row.dart';
import 'package:product_catalog_project/router/app_router.dart';

class ScrollableBookRow extends ConsumerWidget {
  const ScrollableBookRow({super.key});

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
            child: const BookRow(),
          ),
        ),
      ),
    );
  }
}
