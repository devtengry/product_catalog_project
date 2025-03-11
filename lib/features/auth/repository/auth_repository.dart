import 'package:dio/dio.dart';
import 'package:product_catalog_project/core/network/network_service.dart';

class AuthRepository {
  final NetworkService _networkService;

  AuthRepository(this._networkService);

  Future<Response> login(String email, String password) async {
    return await _networkService.postRequest('/login', {
      'email': email,
      'password': password,
    });
  }

  Future<Response> register(String email, String password, String name) async {
    return await _networkService.postRequest('/register', {
      'name': name,
      'email': email,
      'password': password,
    });
  }
}
