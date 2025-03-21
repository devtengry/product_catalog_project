import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/features/book_detail/data/model/product_detail_model.dart';

class ProductDetailRepository {
  final Dio _dio = Dio();

  Future<ProductDetailModel> fetchProductDetail(int productId) async {
    try {
      final response = await _dio
          .get('https://assign-api.piton.com.tr/api/rest/product/$productId');

      if (response.statusCode == 200) {
        return ProductDetailModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load product detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

final productDetailRepositoryProvider =
    Provider((ref) => ProductDetailRepository());
