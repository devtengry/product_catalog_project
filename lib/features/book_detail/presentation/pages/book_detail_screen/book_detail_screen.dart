import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/book_detail/presentation/pages/widgets/buy_button.dart';
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
          onPressed: () {
            Navigator.pop(context);
          },
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
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _BookImage(bookPhotoAsset: _bookPhotoAsset),
                            _BookTitle(),
                            _BookAuthor(),
                            _BookSummary(),
                            SizedBox(
                              width: 350.w,
                              height: 60.h,
                              child: BuyButton(
                                buttonText: 'Buy Now',
                                bookPrice: '70,77 S',
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      width: 44.w,
                      height: 44.h,
                      left: 307,
                      child: Placeholder(
                        color: Colors.red,
                      ),
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

class _BookSummary extends StatelessWidget {
  const _BookSummary();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Summary',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: ProjectColors.darkPurpleText,
              ),
        ),
        Text(
          'Dune is set in the distant future amidst a feudal interstellar society in which various noble houses control planetary fiefs. It tells the story of young Paul Atreides, whose family accepts the stewardship of the planet Arrakis. While the planet is an inhospitable and sparsely populated desert wasteland, it is the only source of melange, or "spice", a drug that...',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ProjectColors.darkPurpleText.withValues(alpha: 0.6),
              ),
        ),
      ],
    );
  }
}

class _BookAuthor extends StatelessWidget {
  const _BookAuthor();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Frank Herbert',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ProjectColors.darkPurpleText.withValues(alpha: 0.6),
          ),
    );
  }
}

class _BookTitle extends StatelessWidget {
  const _BookTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Dune',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 20,
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
      child: Image.asset(_bookPhotoAsset),
    );
  }
}
