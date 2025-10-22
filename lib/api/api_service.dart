import 'dart:convert';

import 'package:dio/dio.dart';

import 'cache.dart';
import 'client.dart';
import '../error_handler.dart';
import 'token_service.dart';

class ApiMethod {
  static const String login = 'login';
  static const String logout = 'logout';
  static const String register = 'register';
  static const String refresh = 'refresh';

  static const String jobs = 'jobs';
  static const String searchJobs = 'searchJob';
  static const String acceptJob = 'acceptJob';
  static const String cancelJob = 'cancelJob';
  static const String newJob = 'newJob';
  static const String removeJob = 'removeJob';
  static const String updateJob = 'updateJob';

  static const String users = 'users';
  static const String updateUser = 'updateUser';
}

class ApiService {
  final cache = Cache();
  final _client = Client.instance;
  final tokenService = TokenService.instance;

  ApiService();

  // User login
  Future<String?> login(String email, String? password) async {
    try {
      final body = {'email': email, 'password': password};
      return await _callAndCache(ApiMethod.login, body, ApiMethod.login);
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.login, e));
    }
    return null;
  }

  // User logout
  Future<bool?> logout() async {
    try {
      final response = await _callAndCache(ApiMethod.logout, null, null);
      if(response != null && response){
        tokenService.deleteAccessToken();
        tokenService.deleteRefreshToken();
        cache.delete(ApiMethod.login);
        return response;
      }
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.login, e));
    }
    return false;
  }

  // Register new user
  Future<String?> register(String username, String email, String password) async {
    try {
      final body = {'username': username, 'email': email, 'password': password};
      return await _callAndCache(ApiMethod.register, body, ApiMethod.login);
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.register, e));
    }
    return null;
  }

  // Refresh access token
  Future<bool> refreshToken() async {
    try {
      final response = await _callAndCache(ApiMethod.refresh, null, null);
      if(response != null) return response;
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.refresh, e));
    }
    return false;
  }

  // Get jobs with ids
  Future<List<String>?> getJobs(List<int> ids) async {
    try {
      final body = {'ids': ids};
      //final response = await _callOrCache(ApiMethod.jobs, body, ApiMethod.jobs);
      return await _callAndCache(ApiMethod.jobs, body, ApiMethod.jobs);
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.jobs, e));
    }
    return null;
  }

  // Get jobs with filter
  Future<List<String>?> searchJobs(Map? filter) async {
    try {
      final body = filter == null ? null : {'filter': filter};
      //final response = await _callOrCache(ApiMethod.searchJobs, body, ApiMethod.jobs);
      return await _callAndCache(ApiMethod.searchJobs, body, ApiMethod.jobs);
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.jobs, e));
    }
    return null;
  }

  // Decode data from response
  dynamic _getValue(dynamic data) async {
    return json.decode(data["value"]);
  }

  // Call api and cache data of response
  Future<dynamic> _callAndCache(String method, Map? body, String? key) async {
    final response = await _client.post(method, body);

    if (response.statusCode == 200 && response.data.contains("value")) {
      if (key != null) await cache.update(key, response.data['value']);
      return response.data['value'];
    }

    return null;
  }

  // Call api or get data from cache
  Future<dynamic> _callOrCache(String method, Map? data, String key) async {
    final response = await _client.post(method, data);

    if (response.statusCode != 200 || !response.data.contains("value")) {
      return await cache.get(key);
    }

    await cache.update(key, response.data["value"]);
    return response.data["value"];
  }

  // Returns dio or api error
  Exception _getError(String method, Object error) {
    return error is DioException
        ? error
        : Error(ErrorCode.apiError, method, error.toString());
  }
}
