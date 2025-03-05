import 'package:dio/dio.dart';

class NetworkService {
  late final Dio _dio;

  NetworkService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://assign-api.piton.com.tr/api/rest",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }
  Future<Response> getRequest(String endpoint) async {
    try {
      return await _dio.get(endpoint);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postRequest(
      String enpoint, Map<String, dynamic> data) async {
    try {
      return await _dio.post(enpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }
}
