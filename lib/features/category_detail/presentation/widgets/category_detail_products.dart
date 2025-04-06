import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/home/data/models/product_model.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/widgets/product_widgets/product_widgets.dart';

class CategoryDetailProducts extends ConsumerWidget {
  final Product product;

  const CategoryDetailProducts({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => router.push(BookDetailRoute(productId: product.id)),
      child: Container(
        width: 170.w,
        height: 284.h,
        decoration: BoxDecoration(
          color: ProjectColors.cardBackground,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Flexible(
                child: AspectRatio(
                  aspectRatio: 150.h / 225.w,
                  child: ProductCoverImage(fileName: product.cover),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Column(
                        spacing: 4.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductNameText(title: product.name),
                          ProductAuthorText(author: product.author),
                        ],
                      ),
                    ),
                    Flexible(
                        child:
                            ProductPriceText(price: product.price.toString())),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
