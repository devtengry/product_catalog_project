import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/features/home/data/models/product_model.dart';
import 'package:product_catalog_project/custom/widgets/product_widgets.dart';

class BookRow extends ConsumerWidget {
  final Product product;

  const BookRow({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        ProductCoverImage(
          fileName: product.cover,
          width: 80.w,
          height: 120.h,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductNameText(title: product.name, fontSize: 12),
                    ProductAuthorText(author: product.author, fontSize: 10),
                  ],
                ),
                Flexible(
                  child: ProductPriceText(
                      price: product.price.toString(), fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
