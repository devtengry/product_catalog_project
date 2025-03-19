import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/features/home/presentation/widgets/home_widgets/book_section/scrollable_book_row.dart';
import 'package:product_catalog_project/features/home/presentation/provider/product_provider.dart';

class HorizontalBookList extends ConsumerWidget {
  final int categoryId;

  const HorizontalBookList({super.key, required this.categoryId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(categoryProductsProvider(categoryId));

    return productAsync.when(
        error: (error, _) => Center(
              child: Text('Error $error'),
            ),
        loading: () => Center(
              child: CircularProgressIndicator(),
            ),
        data: (produtcs) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: produtcs
                  .map(
                    (produtcs) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: AspectRatio(
                          aspectRatio: 240.w / 150.h,
                          child: ScrollableBookRow(product: produtcs)),
                    ),
                  )
                  .toList(),
            )));
  }
}
