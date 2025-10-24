import 'package:dio/dio.dart';

import '../states/classes/job.dart';
import '../error_handler.dart';
import 'cache.dart';
import 'client.dart';
import 'password_utils.dart';
import 'token_service_test.dart';

class ApiMethod {
  static const String login = '/login';
  static const String logout = '/logout';
  static const String register = '/register';
  static const String refresh = '/refresh';

  static const String jobs = '/jobs';
  static const String searchJobs = '/searchJob';
  static const String acceptJob = '/acceptJob';
  static const String cancelJob = '/cancelJob';
  static const String finishJob = '/finishJob';
  static const String newJob = '/newJob';
  static const String removeJob = '/removeJob';
  static const String updateJob = '/updateJob';

  static const String users = '/users';
  static const String updateUser = '/updateUser';
}

class ApiService {
  bool loggedIn = false;
  
  late Cache cache;
  late Client _client;
  late TokenService _tokenService;

  ApiService(){
    cache = Cache();
    _tokenService = TokenService.instance;
    _client = Client.instance;
  }

  // User login
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      if(!(await _checkTokens(false))){
        final body = {'email': email, 'hash': encryptedHash(password)};
        final user = await _callAndCache(ApiMethod.login, body, ApiMethod.login);
        if(user != null) loggedIn = true;
        return user;
      }
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.login, e));
    }
    return null;
  }

  // User logout
  Future<bool> logout() async {
    try {
      await _checkTokens(true);
      
      final response = await _callAndCache(ApiMethod.logout, null, null);
      if(response != null && response){
        loggedIn = false;
        _tokenService.deleteAccessToken();
        _tokenService.deleteRefreshToken();
        cache.delete(ApiMethod.login);
        return response;
        
      }
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.logout, e));
    }
    return false;
  }

  // Register new user
  Future<Map<String, dynamic>?> register(String username, String email, String password) async {
    try {
      if(!(await _checkTokens(false))){
        //final body = {'username': username, 'email': email, 'hash': encryptedHash(password)};
        final body = {'email': email, 'hash': encryptedHash(password)};
        final user = await _callAndCache(ApiMethod.register, body, ApiMethod.login);
        if(user != null) loggedIn = true;
        return user;
      }
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.register, e));
    }
    return null;
  }

  // Refresh access token
  Future<bool> refreshToken() async {
    try {
      await _checkTokens(true);
      
      final response = await _callAndCache(ApiMethod.refresh, null, null);
      if(response != null) return response;
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.refresh, e));
    }
    return false;
  }

  // Update user data
  Future<Map?> updateUser(int id, Map update) async {
    try {
      await _checkTokens(true);
      
      final body = {'id': id, 'update': update};
      return await _callAndCache(ApiMethod.updateUser, body, null);
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.updateUser, e));
    }
    return null;
  }

  // Create new job
  Future<Map?> newJob(Job job) async {
    try {
      await _checkTokens(true);
      
      final body = {'job': job.toJson()};
      return await _callAndCache(ApiMethod.newJob, body, ApiMethod.newJob);
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.newJob, e));
    }
    return null;
  }

  // Accept open job
  Future<Map?> acceptJob(int id, Map data) async {
    try {
      await _checkTokens(true);
      
      final body = {'id': id, 'data': data};
      return await _callAndCache(ApiMethod.acceptJob, body, ApiMethod.acceptJob);
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.acceptJob, e));
    }
    return null;
  }

  // Cancel accepted Job
  Future<bool> cancelJob(int id) async {
    try {
      await _checkTokens(true);
      
      final body = {'id': id};
      final success = await _callAndCache(ApiMethod.cancelJob, body, null);
      if(success) cache.delete(ApiMethod.acceptJob);
      return success;
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.cancelJob, e));
    }
    return false;
  }

  // Finish accepted Job
  Future<bool> finishJob(int id) async {
    try {
      await _checkTokens(true);
      
      final body = {'id': id};
      final success = await _callAndCache(ApiMethod.finishJob, body, null);
      if(success) cache.delete(ApiMethod.acceptJob);
      return success;
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.finishJob, e));
    }
    return false;
  }

  // Remove job
  Future<bool> removeJob(int id) async {
    try {
      await _checkTokens(true);
      
      final body = {'id': id};
      final success = await _callAndCache(ApiMethod.removeJob, body, null);
      if(success) cache.delete(ApiMethod.newJob);
      return success;
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.removeJob, e));
    }
    return false;
  }

  // Update job data
  Future<Map?> updateJob(int id, Map update) async {
    try {
      await _checkTokens(true);
      
      final body = {'id': id, 'update': update};
      return await _callAndCache(ApiMethod.updateJob, body, null);
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.updateJob, e));
    }
    return null;
  }

  // Get jobs with ids
  Future<List<Map>?> getJobs(List<int> ids) async {
    try {
      await _checkTokens(true);
      
      final body = {'ids': ids};
      return await _callAndCache(ApiMethod.jobs, body, ApiMethod.jobs);
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.jobs, e));
    }
    return null;
  }

  // Get jobs with filter
  Future<List<Map>?> searchJobs(Map? filter) async {
    try {
      await _checkTokens(true);
      
      final body = filter == null ? null : {'filter': filter};
      return await _callAndCache(ApiMethod.searchJobs, body, ApiMethod.searchJobs);
    } catch (e) {
      ErrorHandler.handle(_getError(ApiMethod.searchJobs, e));
    }
    return null;
  }

  // Check auth tokens
  Future<bool> _checkTokens(bool throwError) async {
    if(!loggedIn){
      if(throwError) {
        throw Exception('Not logged in');
      }
      return false;
    }
    if(!(await _tokenService.hasToken())){
      loggedIn = false;
      if(throwError) {
        throw Exception('No auth tokens found');
      }
      return false;
    }
    return true;
  }

  // Get response from api method and update cache key
  Future<dynamic> _callAndCache(String method, Map? body, String? key) async {
    final response = await _client.post(method, body);
    if (response != null && response.data.containsKey("value")) {
      if (key != null) await cache.update(key, response.data['value']);
      return response.data["value"];
    }
    return null;
  }

  // Returns dio or api error
  Exception _getError(String method, Object error) {
    return error is DioException
        ? error
        : Error(ErrorCode.apiError, method, error.toString());
  }
}
