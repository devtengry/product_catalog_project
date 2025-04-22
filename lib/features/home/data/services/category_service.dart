import 'package:dio/dio.dart';
import 'package:product_catalog_project/network/network_service.dart';
import 'package:product_catalog_project/features/home/data/models/category_model.dart';

class CategoryService {
  final Dio dio = NetworkService().dio;

  Future<CategoryModel> fetchCategories() async {
    final response = await dio.get('/categories');
    return CategoryModel.fromJson(response.data);
  }
}
