import 'package:dio/dio.dart';
import 'package:product_catalog_project/utils/jwt_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LikeRepository {
  final Dio _dio = Dio();
  final String _baseUrl = dotenv.env['BASE_URL']!;

  Future<void> toggleLike(int productId, String token, bool isLiked) async {
    try {
      final payload = decodeJwt(token);
      final userId = payload?['user_id'] as int?;

      if (userId == null) {
        throw Exception('Invalid JWT token or user ID');
      }

      final endpoint = isLiked ? 'like' : 'unlike';
      final url = '$_baseUrl/$endpoint';

      await _dio.post(
        url,
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
      final errorData = e.response?.data?.toString() ?? 'Unknown error';

      if (errorData.contains('duplicate key')) {
        throw Exception('duplicate key');
      }

      throw Exception('Error: $errorData');
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
