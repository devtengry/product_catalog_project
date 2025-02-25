import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/router/app_router.dart';
import 'package:product_catalog_project/ui/widgets/app_bar/main_app_bar.dart';
import 'package:product_catalog_project/ui/widgets/search_bar/search_bar.dart'
    as custom;

class CategoryDetail extends ConsumerWidget {
  const CategoryDetail({super.key});

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

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRouter.bookDetail),
      child: Container(
        width: 170.w,
        height: 284.h,
        decoration: BoxDecoration(
            color: ProjectColors.cardBackground,
            borderRadius: BorderRadius.circular(4.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Flexible(
                child: AspectRatio(
                  aspectRatio: 150.h / 225.w,
                  child: SizedBox(
                    width: 150.w,
                    height: 225.h,
                    child: Image.asset(
                      _bookAssetImage,
                      fit: BoxFit.cover,
                    ),
                  ),
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
                      Text(
                        'Dune',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: ProjectColors.darkPurpleText,
                            ),
                      ),
                      Text(
                        'Frank Herbert',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: ProjectColors.darkPurpleText
                                  .withValues(alpha: 0.6),
                            ),
                      ),
                    ],
                  ),
                  Text(
                    '87,75',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ProjectColors.priceText,
                        ),
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
