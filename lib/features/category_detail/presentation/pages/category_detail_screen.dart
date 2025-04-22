import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';
import 'package:product_catalog_project/features/category_detail/presentation/widgets/category_detail_products.dart';
import 'package:product_catalog_project/features/home/presentation/provider/product_provider.dart';
import 'package:product_catalog_project/custom/widgets/custom_loading_indicator.dart';
import 'package:product_catalog_project/custom/widgets/main_app_bar.dart';
import 'package:product_catalog_project/common/search_action/widgets/search_bar/search_bar.dart';

@RoutePage()
class CategoryDetailScreen extends ConsumerWidget {
  final int categoryId;

  const CategoryDetailScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(categoryProductsProvider(categoryId));

    return Scaffold(
      backgroundColor: kWhiteBackground,
      appBar: _CategoryDetailAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 30.h,
            children: [
              HomeSearchBar(),
              Expanded(
                child: productAsync.when(
                  error: (error, _) => Center(child: Text('Error: $error')),
                  loading: () => const Center(child: CustomLoadingIndicator()),
                  data: (products) => GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 170.w / 284.h,
                    ),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: CategoryDetailProducts(product: products[index]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryDetailAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MainAppBar(
      suffixText: '',
      leadingIcon: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_new_outlined),
      ),
    );
  }
}
