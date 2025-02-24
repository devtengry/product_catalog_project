import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/theme/text_style/text_styles.dart';

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
