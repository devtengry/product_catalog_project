import 'package:dio/dio.dart';
import 'package:product_catalog_project/core/network/network_service.dart';
import 'package:product_catalog_project/features/home/data/models/cover_image_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsService {
  final Dio dio = NetworkService().dio;

  Future<List<dynamic>> fetchProductsByCategory(int categoryId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await dio.get(
        '/products/$categoryId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data['product'];
    } on DioException catch (e) {
      throw Exception('Api Error: ${e.message}');
    }
  }

  Future<CoverImageResponse> fetchImage() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await dio.get(
        '/cover_image',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // Model nesnesi oluşturarak döndür
      return CoverImageResponse.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? e.message;
      throw Exception('Api Error: $errorMessage');
    }
  }
}
