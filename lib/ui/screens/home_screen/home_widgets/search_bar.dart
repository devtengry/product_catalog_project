import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/core/theme/text_style/text_styles.dart';

final searchControllerProvider = StateProvider<TextEditingController>(
  (ref) => TextEditingController(),
);

class SearchBar extends ConsumerWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(searchControllerProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: SearchField(controller: searchController),
    );
  }
}

class SearchField extends ConsumerWidget {
  const SearchField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: ProjectColors.textFieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const SearchIcons(icon: Icons.search),
        hintText: 'Search',
        hintStyle: TextStyles.searchStyle(context),
        suffixIcon: const SearchIcons(icon: Icons.tune),
      ),
    );
  }
}

class SearchIcons extends ConsumerWidget {
  const SearchIcons({
    super.key,
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
