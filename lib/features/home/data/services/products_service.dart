import 'package:dio/dio.dart';
import 'package:product_catalog_project/core/constants/app_constants.dart';
import 'package:product_catalog_project/core/network/network_service.dart';
import 'package:product_catalog_project/utils/shared_preferences_helper.dart';

class ProductsService {
  final Dio dio = NetworkService().dio;

  Future<List<dynamic>> fetchProductsByCategory(int categoryId) async {
    try {
      final prefs = await getSharedPreferences();
      final token = prefs.getString(AppConstants.tokenKey);

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
