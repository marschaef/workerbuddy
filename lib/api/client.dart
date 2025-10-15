import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'cache.dart';
import 'token_service.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/cache_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

// App client to handle api calls, access tokens and cache
class Client {
  late final Dio _dio;
  final _cache = Cache();
  final _tokenService = TokenService.instance;

  final _cacheTime = 60;

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
    _dio.interceptors.add(CacheInterceptor(_cache));
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

  // Call api with loader and error handling
  FutureBuilder<dynamic> call(String key, String? data) {
    return FutureBuilder<dynamic>(
      future: _cacheOrCall(key, data),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.toString());
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  // Call api with loader and error handling
  Future<dynamic> _cacheOrCall(String key, String? data) async {
    if (_shouldUseCache(key)) {
      final cache = await _cache.getCache(key);
      final cacheObj = json.decode(await _cache.getCache(key));
      int now = (DateTime.now().microsecondsSinceEpoch ~/ 1000).toInt();

      if (now - int.parse(cacheObj["timstamp"]) < _cacheTime) {
        return cache;
      }
    }
    return await post(key, data);
  }

  // Determine if the request should be retried.
  bool _shouldUseCache(String key) {
    return key == "user";
  }

  // Debouncing request to prevent multiple calls at once
  Future<dynamic> _debouncedRequest(Future<Response<dynamic>> Function() request) async {
    _debounceTimer?.cancel();
    _cancelToken?.cancel();

    _cancelToken = CancelToken();
    Completer<dynamic> completer = Completer();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      try {
        final response = await request();
        completer.complete(json.decode(response.toString()));
      } on DioException catch (e) {
        completer.complete(
          e.response != null ? json.decode(e.response.toString()) : null,
        );
      } catch (e) {
        debugPrint('Unexpected error: $e');
        completer.complete(null);
      }
    });

    return completer.future;
  }
}
