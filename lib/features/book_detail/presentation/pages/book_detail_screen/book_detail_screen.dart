import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/book_detail/presentation/pages/widgets/buy_button.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/widgets/app_bar/main_app_bar.dart';

@RoutePage()
class BookDetailScreen extends ConsumerStatefulWidget {
  const BookDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BookDetailScreenState();
}

class _BookDetailScreenState extends ConsumerState<BookDetailScreen> {
  final String _bookPhotoAsset = AssetsPath().bookAssetPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      appBar: MainAppBar(
        suffixText: 'Book Details',
        leadingIcon: IconButton(
          onPressed: () => context.router.popForced(),
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Center(
                        child: Column(
                          spacing: 40.h,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                    child: _BookImage(
                                        bookPhotoAsset: _bookPhotoAsset)),
                                _BookTitle(
                                  bookTitle: 'Dune',
                                ),
                                _BookAuthor(
                                  bookAuthor: 'Frank Herbert',
                                ),
                              ],
                            ),
                            _BookSummary(
                              summaryTitle: 'Summary',
                              bookSummary:
                                  'Dune is set in the distant future amidst a feudal interstellar society in which various noble houses control planetary fiefs. It tells the story of young Paul Atreides, whose family accepts the stewardship of the planet Arrakis. While the planet is an inhospitable and sparsely populated desert wasteland, it is the only source of melange, or "spice", a drug that...',
                            ),
                            _BuyButton(
                              buttonText: 'Buy Now',
                              bookPrice: '87.75',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.h,
                      right: 0.w,
                      child: _LikeButton(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final likeButtonProvider = StateProvider<bool>((ref) => false);

class _LikeButton extends ConsumerStatefulWidget {
  @override
  ConsumerState<_LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends ConsumerState<_LikeButton> {
  @override
  Widget build(BuildContext context) {
    final isClicked = ref.watch(likeButtonProvider);

    final likeIcon = isClicked
        ? Icon(
            Icons.favorite_rounded,
            color: ProjectColors.likeButtonHeart,
          )
        : Icon(
            Icons.favorite_border_rounded,
            color: ProjectColors.likeButtonHeart,
          );
    return Container(
      width: 44.w,
      height: 44.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ProjectColors.likeButtonContainer,
      ),
      child: IconButton(
          onPressed: () =>
              ref.read(likeButtonProvider.notifier).state = !isClicked,
          icon: likeIcon),
    );
  }
}

class _BuyButton extends StatelessWidget {
  final String buttonText;
  final String bookPrice;
  const _BuyButton({
    super.key,
    required this.buttonText,
    required this.bookPrice,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      height: 60.h,
      child: BuyButton(
        buttonText: buttonText,
        bookPrice: '${bookPrice} \$',
        onPressed: () => router.push(
          HomeRoute(),
        ),
      ),
    );
  }
}

class _BookSummary extends StatelessWidget {
  final String bookSummary;
  final String summaryTitle;
  const _BookSummary({required this.bookSummary, required this.summaryTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          summaryTitle,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: min(20.sp, 20),
                fontWeight: FontWeight.w700,
                color: ProjectColors.darkPurpleText,
              ),
        ),
        Text(
          bookSummary,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: min(16.sp, 16),
                height: 1.6,
                fontWeight: FontWeight.w400,
                color: ProjectColors.darkPurpleText.withValues(alpha: 0.6),
              ),
        ),
      ],
    );
  }
}

class _BookAuthor extends StatelessWidget {
  final String bookAuthor;
  const _BookAuthor({required this.bookAuthor});

  @override
  Widget build(BuildContext context) {
    return Text(
      bookAuthor,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(16.sp, 16),
            fontWeight: FontWeight.w600,
            color: ProjectColors.darkPurpleText.withValues(alpha: 0.6),
          ),
    );
  }
}

class _BookTitle extends StatelessWidget {
  final String bookTitle;

  const _BookTitle({required this.bookTitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      bookTitle,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(20.sp, 20),
            fontWeight: FontWeight.w700,
            color: ProjectColors.darkPurpleText,
          ),
    );
  }
}

class _BookImage extends StatelessWidget {
  const _BookImage({
    required String bookPhotoAsset,
  }) : _bookPhotoAsset = bookPhotoAsset;

  final String _bookPhotoAsset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      height: 225.h,
      //make it dynamic later
      child: Image.asset(
        _bookPhotoAsset,
        fit: BoxFit.contain,
      ),
    );
  }
}
