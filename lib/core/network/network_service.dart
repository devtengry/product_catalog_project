import 'package:dio/dio.dart';
import 'package:product_catalog_project/config/secrets.dart';

class NetworkService {
  late final Dio _dio;

  NetworkService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Secrets.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() {
    return _instance;
  }
  Dio get dio => _dio;

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
