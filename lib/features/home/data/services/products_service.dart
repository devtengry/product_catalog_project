import 'package:dio/dio.dart';
import 'package:product_catalog_project/config/secrets.dart';

class ProductsService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Secrets.productByCategoryUrl,
      connectTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<dynamic>> fetchProductsByCategory(int categoryId) async {
    try {
      final response = await dio.get('$categoryId');
      return response.data['product'];
    } on DioException catch (e) {
      throw Exception('Api Error: ${e.message}');
    }
  }
}
