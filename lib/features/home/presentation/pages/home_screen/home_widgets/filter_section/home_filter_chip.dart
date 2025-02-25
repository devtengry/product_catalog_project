import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

class HomeFilterChip extends ConsumerWidget {
  const HomeFilterChip({
    super.key,
    required this.filterText,
  });

  final String filterText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: SizedBox(
        height: 42.h,
        child: FilterChipWidget(filterText: filterText),
      ),
    );
  }
}

class FilterChipWidget extends ConsumerStatefulWidget {
  const FilterChipWidget({
    super.key,
    required this.filterText,
  });

  final String filterText;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterChipWidgetState();
}

class _FilterChipWidgetState extends ConsumerState<FilterChipWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      backgroundColor: ProjectColors.cardBackground,
      selectedColor: ProjectColors.checkboxColor,
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide.none,
      ),
      side: BorderSide(color: Colors.transparent),
      label: Text(
        widget.filterText,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ProjectColors.darkPurpleText.withValues(
                alpha: 0.4,
              ),
            ),
      ),
      selected: isSelected,
      onSelected: (value) {
        setState(() {
          isSelected = value;
        });
      },
    );
  }
}
