import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

class HomeFilterChip extends ConsumerStatefulWidget {
  const HomeFilterChip({
    super.key,
    required this.filterText,
  });

  final String filterText;

  @override
  ConsumerState<HomeFilterChip> createState() => _HomeFilterChipState();
}

class _HomeFilterChipState extends ConsumerState<HomeFilterChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: SizedBox(
        height: 42.h,
        child: FilterChipWidget(filterText: widget.filterText),
      ),
    );
  }
}

final filterChipStateProvider = StateProvider<Map<String, bool>>((ref) => {});

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
  @override
  Widget build(BuildContext context) {
    final isSelected =
        ref.watch(filterChipStateProvider)[widget.filterText] ?? false;
    var checkboxColor = ProjectColors.checkboxColor;
    var cardBackground = ProjectColors.cardBackground;
    return FilterChip(
        backgroundColor: cardBackground,
        selectedColor: checkboxColor,
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
              color: isSelected
                  ? ProjectColors.whiteText
                  : ProjectColors.darkPurpleText.withValues(alpha: 0.4)),
        ),
        selected: isSelected,
        onSelected: (bool selected) =>
            ref.read(filterChipStateProvider.notifier).state = {
              ...ref.read(filterChipStateProvider),
              widget.filterText: selected
            });
  }
}
