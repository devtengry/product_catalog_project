import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/ui/screens/home_screen/home_widgets/category_section/category_card.dart';
import 'package:product_catalog_project/ui/screens/home_screen/home_widgets/home_filter_chip.dart';
import 'package:product_catalog_project/ui/screens/home_screen/home_widgets/search_bar.dart'
    as custom;
import 'package:product_catalog_project/ui/widgets/app_bar/main_app_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final String _logoAssetPath = AssetsPath().logoAssetPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      appBar: MainAppBar(
        leadingIcon: Image.asset(_logoAssetPath),
        suffixText: 'Catalog',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 10.w,
                  children: [
                    HomeFilterChip(filterText: 'All'),
                    HomeFilterChip(filterText: 'Classics'),
                    HomeFilterChip(filterText: 'Horror'),
                    HomeFilterChip(filterText: 'Romance'),
                    HomeFilterChip(filterText: 'Science Fiction'),
                  ],
                ),
              ),
              custom.SearchBar(),
              Spacer(),
              Column(
                spacing: 40,
                children: [
                  CategoryCard(
                    categoryName: 'Best Seller',
                  ),
                  CategoryCard(
                    categoryName: 'Classics',
                  ),
                  CategoryCard(
                    categoryName: 'Horror',
                  ),
                  CategoryCard(
                    categoryName: 'Romance',
                  ),
                  CategoryCard(
                    categoryName: 'Science Fiction',
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
