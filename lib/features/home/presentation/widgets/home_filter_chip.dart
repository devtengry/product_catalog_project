import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';
import 'package:product_catalog_project/features/home/presentation/provider/selected_category_provider.dart';

class HomeFilterChip extends ConsumerWidget {
  const HomeFilterChip({
    super.key,
    required this.filterText,
    required this.categoryId,
  });

  final String filterText;
  final int categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final isSelected = selectedCategory == categoryId;

    return FilterChip(
      backgroundColor: kCardBackground,
      selectedColor: kCheckboxColor,
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide.none,
      ),
      side: const BorderSide(color: Colors.transparent),
      label: Text(
        filterText,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: min(16.sp, 16),
              fontWeight: FontWeight.w400,
              color: isSelected
                  ? kWhiteText
                  : kDarkPurpleText.withValues(alpha: 0.4),
            ),
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        ref.read(selectedCategoryProvider.notifier).state = categoryId;
      },
    );
  }
}
