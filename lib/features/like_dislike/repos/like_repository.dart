import 'package:dio/dio.dart';
import 'package:product_catalog_project/utils/jwt_helper.dart';

class LikeRepository {
  final Dio _dio = Dio();

  Future<void> toggleLike(int productId, String token, bool isLiked) async {
    try {
      final payload = decodeJwt(token);
      final userId = payload?['user_id'] as int?;

      if (userId == null) {
        throw Exception('Invalid JWT token or user ID');
      }

      final endpoint = isLiked ? 'like' : 'unlike';

      await _dio.post(
        'https://assign-api.piton.com.tr/api/rest/$endpoint',
        data: {
          'user_id': userId,
          'product_id': productId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Exception _handleDioError(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data?.toString() ?? 'Unknown error';

    switch (statusCode) {
      case 400:
        return Exception(data.contains('duplicate key')
            ? 'This product is already liked'
            : 'Invalid request');
      case 401:
        return Exception('Unauthorized operation - Please log in again');
      case 404:
        return Exception('Resource not found');
      default:
        return Exception('Error code $statusCode: $data');
    }
  }
}
