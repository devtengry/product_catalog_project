import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

final searchControllerProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
);

class SearchBar extends ConsumerWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(searchControllerProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: _SearchField(
        controller: searchController,
        textInputType: TextInputType.none,
      ),
    );
  }
}

class _SearchField extends ConsumerWidget {
  final TextInputType textInputType;
  const _SearchField({required this.controller, required this.textInputType});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      keyboardType: TextInputType.numberWithOptions(),
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: ProjectColors.textFieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const _SearchIcons(icon: Icons.search),
        hintText: 'Search',
        hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ProjectColors.darkPurpleText.withValues(
                alpha: 0.4,
              ),
            ),
        suffixIcon: const _SearchIcons(icon: Icons.tune),
      ),
    );
  }
}

class _SearchIcons extends ConsumerWidget {
  const _SearchIcons({
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Icon(
      icon,
      color: ProjectColors.iconColor.withAlpha(102),
    );
  }
}
