import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/ui/screens/home_screen/home_widgets/category_section/book_row.dart';

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
