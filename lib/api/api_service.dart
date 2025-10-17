import 'dart:convert';

import 'package:dio/dio.dart';

import '../error_handler.dart';
import 'cache.dart';
import 'client.dart';
import 'methods.dart';
import 'token_service.dart';

class ApiService {
  final cache = Cache();
  final _client = Client.instance;
  final _tokenService = TokenService.instance;

  ApiService();

  // User login
  Future<Map?> login(
    String email,
    String? password,
  ) async {
    try {
      final body = {'email': email, 'password': password};
      final response = await _client.post(ApiMethod.login, body);

      if (response != null) {
        await cache.update("user", response);
        return json.decode(response)["value"];
      }
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.login, e));
    }
    return null;
  }

  // User logout
  Future<Map?> logout() async {
    try {
      final response = await _client.post(ApiMethod.logout, null);

      if (response != null) {
        await cache.clear();
        _tokenService.deleteAccessToken();
        _tokenService.deleteRefreshToken();
        return json.decode(response)["value"];
      }
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.login, e));
    }
    return null;
  }

  // Register new user
  Future<Map?> register(String username, String email, String password) async {
    try {
      final body = {'username': username, 'email': email, 'password': password};
      final response = await _client.post(ApiMethod.register, body);

      if (response != null) {
        await cache.update("user", response);
        return json.decode(response)["value"];
      }
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.register, e));
    }
    return null;
  }

  // Refresh access token
  Future<bool> refreshToken() async {
    try {
      final response = await _client.post(ApiMethod.refresh, null);
      if (response != null) return true;
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.refresh, e));
    }
    return false;
  }

  // Get jobs with filter
  Future<List<Map>?> getJobs(Map? filter) async {
    try {
      final body = filter == null ? null : {'filter': filter};
      final response = await _callOrCache(ApiMethod.jobs, body, ApiMethod.jobs);

      if (response != null) return _getValue(response);
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.jobs, e));
    }
    return null;
  }

  // Call api or use date from cache
  dynamic _getValue(String response) async {
    return json.decode(response)["value"];
  }

  // Call api or use date from cache
  Future<dynamic> _callOrCache(String method, Map? data, String key) async {
    final response = await _client.post(method, data);

    if (response == null) return await cache.get(key);

    await cache.update(key, response);
    return response;
  }

  // Returns dio or api error
  Exception _getError(String method, Object error) {
    return error is DioException
        ? error
        : ApiException(method, ResponseCode.apiError, error.toString());
  }
}
