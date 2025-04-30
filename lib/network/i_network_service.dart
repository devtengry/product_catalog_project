import 'package:dio/dio.dart';

abstract class INetworkService {
  Dio get dio;

  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? queryParameters});
  Future<Response> postRequest(String endpoint, Map<String, dynamic> data);
}
