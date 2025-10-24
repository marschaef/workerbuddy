import 'dart:async';

import 'package:dio/dio.dart';

import '../error_handler.dart';
import 'token_service_test.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

// App client to handle api calls, access tokens and cache
class Client {
  late final Dio _dio;
  late final TokenService _tokenService;

  final Map<String, Timer?> _debounceTimers = {};
  final Map<String, CancelToken?> _cancelTokens = {};

  // Private constructor
  Client._privateConstructor() {
    _tokenService = TokenService.instance;
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://127.0.0.1:8080/api',
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 3),
        validateStatus: (status) {
          return status! < 500;
        },
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
  Future<Response<dynamic>?> get(String path) async {
    return await _debouncedRequest(
      path,
      () => _dio.get(path, cancelToken: _cancelTokens[path]),
    );
  }

  // Call POST api methods
  Future<Response<dynamic>?> post(String path, Object? data) async {
    return await _debouncedRequest(
      path,
      () => _dio.post(path, data: data, cancelToken: _cancelTokens[path]),
    );
  }

  // Debouncing request to prevent multiple calls at once
  Future<Response<dynamic>?> _debouncedRequest(
    String path,
    Future<Response<dynamic>> Function() request,
  ) async {
    _debounceTimers[path]?.cancel();
    _cancelTokens[path]?.cancel();
    _cancelTokens[path] = CancelToken();
    Completer<Response<dynamic>?> completer = Completer();

    _debounceTimers[path] = Timer(const Duration(milliseconds: 500), () async {
      try {
        final response = await request();
        if (response.statusCode == 200) {
          completer.complete(response);
        } else if (response.statusCode == 400) {
          ErrorHandler.handle(DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: response.data.toString(),
          ));
          completer.complete(null);
        } else {
          completer.complete(null);
        }
      } catch (e) {
        completer.complete(null);
        ErrorHandler.handle(
          e is DioException ? e : Error(ErrorCode.apiError, path, e.toString()),
        );
      }
    });

    return completer.future;
  }
}
