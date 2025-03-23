import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/features/home/presentation/provider/product_provider.dart';
import 'package:product_catalog_project/features/home/presentation/widgets/home_widgets/book_section/scrollable_book_row.dart';

class HorizontalBookList extends ConsumerWidget {
  final int categoryId;

  const HorizontalBookList({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(categoryProductsProvider(categoryId));

    return productAsync.when(
      error: (error, _) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (products) {
        if (products.isEmpty) {
          return const Center(child: Text("No products found."));
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: products
                .map(
                  (product) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      width: 240.w, // Burada genişlik veriyoruz
                      height: 150.h, // Burada yükseklik veriyoruz
                      child: AspectRatio(
                        aspectRatio: 240.w / 150.h,
                        child: ScrollableBookRow(product: product),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
