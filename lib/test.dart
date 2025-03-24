import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/home/presentation/widgets/home_widgets/category_section/category_card.dart';
import 'package:product_catalog_project/features/home/presentation/provider/category_provider.dart';
import 'package:product_catalog_project/features/home/presentation/widgets/home_widgets/filter_section/home_filter_chip.dart';
import 'package:product_catalog_project/features/search/presentation/widgets/search_bar/search_bar.dart';
import 'package:product_catalog_project/ui/widgets/app_bar/main_app_bar.dart';

@RoutePage()
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
                    //dummy filter
                  ],
                ),
              ),
              HomeSearchBar(),
              Column(
                spacing: 20,
                children: ref.watch(categoryProvider).when(
                      data: (data) {
                        final categories = data.category ?? [];
                        return categories.map((category) {
                          return CategoryCard(
                            category: category,
                          );
                        }).toList();
                      },
                      loading: () =>
                          [const Center(child: CircularProgressIndicator())],
                      error: (err, stack) =>
                          [Center(child: Text('Error: $err'))],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
