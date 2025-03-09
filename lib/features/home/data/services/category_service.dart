import 'package:dio/dio.dart';
import 'package:product_catalog_project/config/secrets.dart';
import 'package:product_catalog_project/features/home/data/models/category_model.dart';

class CategoryService {
  final Dio _dio = Dio();
  final String _baseUrl = Secrets.baseUrl;

  Future<CategoryModel> fetchCategories() async {
    final response = await _dio.get('$_baseUrl/categories');
    return CategoryModel.fromJson(response.data);
  }
}
