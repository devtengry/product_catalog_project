// ignore_for_file: unused_element

import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/widgets/app_bar/main_app_bar.dart';
import 'package:product_catalog_project/ui/widgets/search_bar/search_bar.dart'
    as custom;

@RoutePage()
class CategoryDetailScreen extends ConsumerWidget {
  const CategoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      appBar: MainAppBar(
        suffixText: 'Best Seller',
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            custom.SearchBar(),
            Expanded(
              child: GridView.builder(
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 170.w / 284.h,
                ),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: _CategoryDetailBook(),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class _CategoryDetailBook extends ConsumerStatefulWidget {
  const _CategoryDetailBook({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoryDetailBookState();
}

class _CategoryDetailBookState extends ConsumerState<_CategoryDetailBook> {
  final String _bookAssetImage = AssetsPath().bookAssetPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => router.push(BookDetailRoute()),
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
                  child: _BookCoverImage(bookAssetImage: _bookAssetImage),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TitleText(
                        bookTitle: 'Dune',
                      ),
                      _AuthorText(
                        bookAuthor: 'Frank Herbert',
                      ),
                    ],
                  ),
                  _PriceText(
                    bookPrice: '87,75',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookCoverImage extends StatelessWidget {
  const _BookCoverImage({
    super.key,
    required String bookAssetImage,
  }) : _bookAssetImage = bookAssetImage;

  final String _bookAssetImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: min(150.w, 150),
      height: min(225.h, 225),
      child: AspectRatio(
        aspectRatio: 120.h / 80.w,
        child: Image.asset(
          _bookAssetImage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String bookTitle;

  const _TitleText({super.key, required this.bookTitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      bookTitle,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(10.sp, 10),
            fontWeight: FontWeight.w600,
            color: ProjectColors.darkPurpleText,
          ),
    );
  }
}

class _AuthorText extends StatelessWidget {
  final String bookAuthor;

  const _AuthorText({
    super.key,
    required this.bookAuthor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      bookAuthor,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(8.sp, 8),
            fontWeight: FontWeight.w700,
            color: ProjectColors.darkPurpleText.withValues(alpha: 0.6),
          ),
    );
  }
}

class _PriceText extends StatelessWidget {
  final String bookPrice;

  const _PriceText({
    super.key,
    required this.bookPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${bookPrice} \$',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(12.sp, 12),
            fontWeight: FontWeight.w700,
            color: ProjectColors.priceText,
          ),
    );
  }
}
