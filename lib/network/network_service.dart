import 'package:dio/dio.dart';
import 'package:product_catalog_project/config/secrets.dart';
import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';

//TODO: interface olarak genel bir yapı oluşturulabilir ve burada o interface'ten implemenet alınabilir burada.
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

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await AuthStorage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {}
        handler.next(e);
      },
    ));
  }

  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() {
    return _instance;
  }

  Dio get dio => _dio;

  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }
}
