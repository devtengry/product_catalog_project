import 'package:dio/dio.dart';
import 'package:product_catalog_project/core/network/network_service.dart';
import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';

class ProductsService {
  final Dio dio = NetworkService().dio;

  Future<List<dynamic>> fetchProductsByCategory(int categoryId) async {
    try {
      final response = await dio.get('/products/$categoryId');
      return response.data['product'];
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        print("Unauthorized request! Clearing session.");
        await AuthStorage.deleteToken();
      }
      throw Exception('API Error: ${e.message}');
    }
  }

  Future<String> fetchCoverImage(String fileName) async {
    try {
      final response = await dio.post(
        '/cover_image',
        data: {"fileName": fileName},
      );
      return response.data["action_product_image"]["url"];
    } on DioException catch (e) {
      throw Exception('Failed to load cover image: ${e.message}');
    }
  }
}
