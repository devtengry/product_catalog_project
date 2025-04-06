import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/home/data/models/product_model.dart';
import 'package:product_catalog_project/features/home/presentation/provider/product_provider.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/widgets/app_bar/main_app_bar.dart';
import 'package:product_catalog_project/features/search/presentation/widgets/search_bar/search_bar.dart';
import 'package:product_catalog_project/ui/widgets/product_widgets/product_widgets.dart';

@RoutePage()
class CategoryDetailScreen extends ConsumerWidget {
  final int categoryId;

  const CategoryDetailScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(categoryProductsProvider(categoryId));

    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      appBar: MainAppBar(
        suffixText: 'Best Seller',
        leadingIcon: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const HomeSearchBar(),
              Expanded(
                child: productAsync.when(
                  error: (error, _) => Center(child: Text('$error')),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  data: (products) => GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 170.w / 284.h,
                    ),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: CategoryDetailBookCard(product: products[index]),
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

class CategoryDetailBookCard extends StatelessWidget {
  final Product product;

  const CategoryDetailBookCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => router.push(BookDetailRoute(productId: product.id)),
      child: Container(
        width: 170.w,
        height: 284.h,
        decoration: BoxDecoration(
          color: ProjectColors.cardBackground,
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 150.h / 225.w,
                child:
                    Expanded(child: ProductCoverImage(fileName: product.cover)),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductNameText(
                        title: product.name,
                        fontSize: min(10.sp, 10),
                      ),
                      ProductAuthorText(
                        author: product.author,
                        fontSize: min(8.sp, 8),
                      ),
                    ],
                  ),
                ),
                ProductPriceText(
                  price: product.price.toString(),
                  fontSize: min(12.sp, 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
