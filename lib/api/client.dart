import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import 'token_service.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

// App client to handle api calls, access tokens and cache
class Client {
  late final Dio _dio;
  final _tokenService = TokenService.instance;

  Timer? _debounceTimer;
  CancelToken? _cancelToken;

  Client._privateConstructor() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://127.0.0.1:5000/api',
        connectTimeout: Duration(microseconds: 5000),
        receiveTimeout: Duration(microseconds: 3000),
      ),
    );
    _initializeInterceptors();
  }

  // Singelton instance
  static final Client instance = Client._privateConstructor();

  // Initialize Interceptors
  void _initializeInterceptors() {
    _dio.interceptors.add(AuthInterceptor(_dio, _tokenService));
    //_dio.interceptors.add(CacheInterceptor(_cache));
    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(RetryInterceptor(_dio));
  }

  // Call GET api methods
  Future<dynamic> get(String path) async {
    return await _debouncedRequest(() => _dio.get(path, cancelToken: _cancelToken));
  }

  // Call POST api methods
  Future<dynamic> post(String path, Object? data) async {
    return await _debouncedRequest(
      () => _dio.post(path, data: data, cancelToken: _cancelToken),
    );
  }

  // Debouncing request to prevent multiple calls at once
  Future<dynamic> _debouncedRequest(Future<Response<dynamic>> Function() request) async {
    _debounceTimer?.cancel();
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    Completer<dynamic> completer = Completer();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final response = await request();
      if(response.statusCode == 200){
        completer.complete(json.decode(response.toString()));
      }
      completer.complete(null);
    });

    return completer.future;
  }
}
