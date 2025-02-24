import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/theme/text_style/text_styles.dart';

class BookRow extends ConsumerWidget {
  const BookRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        SizedBox(
          width: 80.w,
          height: 120.h,
          child: Image.asset('assets/images/dune_book.png'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dune', style: TextStyles.bookTitle12SemiBold(context)),
                  Text('Frank Herbert', style: TextStyles.authorStyle(context)),
                ],
              ),
              Text('87,75', style: TextStyles.priceStyle(context)),
            ],
          ),
        ),
      ],
    );
  }
}
