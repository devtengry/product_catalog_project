import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_project/core/constants/assets_path.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';
import 'package:product_catalog_project/features/home/data/models/category_model.dart';
import 'package:product_catalog_project/features/home/presentation/widgets/home_widgets/category_section/category_card.dart';
import 'package:product_catalog_project/features/filter_feature/presentation/widgets/home_filter_chip.dart';
import 'package:product_catalog_project/features/home/presentation/provider/category_provider.dart';
import 'package:product_catalog_project/features/search/presentation/widgets/search_bar/search_bar.dart';
import 'package:product_catalog_project/ui/widgets/app_bar/main_app_bar.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: ProjectColors.whiteBackground,
      appBar: MainAppBar(
        leadingIcon: Image.asset(AssetsPath().logoAssetPath),
        suffixText: 'Catalog',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            spacing: 20.w,
            children: [
              // Filtre butonları
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // "All" filtresi
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: HomeFilterChip(
                        filterText: "All",
                        categoryId: 0, // "All" için ID 0
                      ),
                    ),
                    // API'den gelen kategoriler
                    ...ref.watch(categoryProvider).when(
                          data: (data) {
                            final categories = data.category ?? [];
                            return categories.map((category) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: HomeFilterChip(
                                  filterText: category.name ?? '',
                                  categoryId: category.id ?? 0,
                                ),
                              );
                            }).toList();
                          },
                          loading: () => [const CircularProgressIndicator()],
                          error: (err, stack) => [Text('Error: $err')],
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
                          // Show all categories with their cards
                          return ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return CategoryCard(
                                  category: category); // Use CategoryCard
                            },
                          );
                        } else {
                          // Show only the selected category's card
                          final selectedCat = categories.firstWhere(
                            (cat) => cat.id == selectedCategory,
                            orElse: () => Category(),
                          );
                          return CategoryCard(category: selectedCat);
                        }
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('Error: $err')),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
