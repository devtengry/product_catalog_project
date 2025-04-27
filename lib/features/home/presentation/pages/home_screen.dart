import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/text_constants.dart';
import 'package:product_catalog_project/gen/assets.gen.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';
import 'package:product_catalog_project/features/home/presentation/provider/selected_category_provider.dart';
import 'package:product_catalog_project/features/home/data/models/category_model.dart';
import 'package:product_catalog_project/features/home/presentation/widgets/home_widgets/category_section/category_card.dart';
import 'package:product_catalog_project/features/home/presentation/widgets/home_widgets/home_filter_chip.dart';
import 'package:product_catalog_project/features/home/presentation/provider/category_provider.dart';
import 'package:product_catalog_project/common/search_action/widgets/search_bar/search_bar.dart';
import 'package:product_catalog_project/custom/widgets/custom_loading_indicator.dart';
import 'package:product_catalog_project/custom/widgets/main_app_bar.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: kWhiteBackground,
      appBar: MainAppBar(
        leadingIcon: Image.asset(Assets.images.logo.path),
        suffixText: catalogText,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            spacing: 20.w,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: HomeFilterChip(
                        filterText: allText,
                        categoryId: 0,
                      ),
                    ),
                    ...ref.watch(categoryProvider).when(
                          data: (data) {
                            final categories = data.category ?? [];
                            return categories.map((category) {
                              assert(category.fields != null, anErrorText);
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: HomeFilterChip(
                                  filterText:
                                      category.fields!.name ?? anErrorText,
                                  categoryId: category.fields!.id ?? 0,
                                ),
                              );
                            }).toList();
                          },
                          loading: () => [
                            SizedBox(
                              width: 10.w,
                              height: 10.h,
                              child: const CustomLoadingIndicator(),
                            )
                          ],
                          error: (err, stack) => [Text(filterFailText)],
                        ),
                  ],
                ),
              ),
              const HomeSearchBar(),
              Flexible(
                child: ref.watch(categoryProvider).when(
                      data: (data) {
                        final categories = data.category ?? [];

                        if (selectedCategory == 0) {
                          return ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              assert(category.fields != null, anErrorText);
                              return CategoryCard(category: category);
                            },
                          );
                        } else {
                          final selectedCat = categories.firstWhere(
                            (cat) {
                              assert(cat.fields != null, anErrorText);
                              return cat.fields!.id == selectedCategory;
                            },
                            orElse: () => Category(),
                          );
                          return CategoryCard(category: selectedCat);
                        }
                      },
                      loading: () =>
                          const Center(child: CustomLoadingIndicator()),
                      error: (err, stack) => Center(child: Text('$err')),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
