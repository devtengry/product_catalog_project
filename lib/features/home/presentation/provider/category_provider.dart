import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/home/data/models/category_model.dart';
import 'package:product_catalog_project/features/home/data/services/category_service.dart';

final categoryServiceProvider = Provider((ref) => CategoryService());

final categoryProvider = FutureProvider<CategoryModel>(
  (ref) async {
    final service = ref.watch(categoryServiceProvider);
    try {
      return await service.fetchCategories();
    } catch (e) {
      throw "Failed to load categories. Please try again.";
    }
  },
);
