import 'package:dio/dio.dart';
import 'package:product_catalog_project/core/network/network_service.dart';
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
}
