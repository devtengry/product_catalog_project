import 'package:dio/dio.dart';
import 'package:product_catalog_project/features/home/data/models/category_model.dart';

class CategoryService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://assign-api.piton.com.tr/api/rest';

  Future<CategoryModel> fetchCategories() async {
    final response = await _dio.get('$_baseUrl/categories');
    return CategoryModel.fromJson(response.data);
  }
}
