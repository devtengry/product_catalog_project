import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/home/presentation/pages/home_screen/home_widgets/book_section/scrollable_book_row.dart';

class HorizontalBookList extends ConsumerWidget {
  const HorizontalBookList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
          (index) => const Padding(
            padding: EdgeInsets.only(right: 10),
            child: ScrollableBookRow(),
          ),
        ),
      ),
    );
  }
}
