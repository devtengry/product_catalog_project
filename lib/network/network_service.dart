import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:product_catalog_project/config/secrets.dart';
import 'package:product_catalog_project/features/auth/data/services/auth_storage.dart';
import 'package:product_catalog_project/network/i_network_service.dart';

@LazySingleton(as: INetworkService)
class NetworkService implements INetworkService {
  late final Dio _dio;

  NetworkService() {
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
        if (e.response?.statusCode == 401) {
          // TODO: Token yenileme işlemleri yapılabilir
        }
        handler.next(e);
      },
    ));
  }

  @override
  Dio get dio => _dio;

  @override
  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }
}
