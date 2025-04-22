import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';
import 'package:product_catalog_project/features/auth/presentation/widgets/snack_bar_manager.dart';
import 'package:product_catalog_project/common/search_action/hooks/use_filtered_products.dart';
import 'package:product_catalog_project/common/search_action/providers/search_provider.dart';
import 'package:product_catalog_project/router/app_router.dart';

class HomeSearchBar extends HookConsumerWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    useEffect(() {
      return () => searchController.dispose();
    }, []);

    return Flexible(
      flex: 0,
      fit: FlexFit.tight,
      child: TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: kTextFieldBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const _SearchIcons(icon: Icons.search),
          hintText: 'Search',
          hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: kDarkPurpleText.withAlpha(102),
              ),
          suffixIcon: const _SearchIcons(icon: Icons.tune_outlined),
        ),
        onSubmitted: (value) async {
          ref.read(searchQueryProvider.notifier).state = value;

          final filteredProducts = await useFilteredProductsAsync(ref);
          if (filteredProducts.isNotEmpty) {
            context.router
                .push(BookDetailRoute(productId: filteredProducts.first.id));
          } else {
            SnackBarManager(context)
                .showErrorSnackBar('No matching products found.');
          }
        },
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
      color: kIconColor.withAlpha(102),
    );
  }
}
