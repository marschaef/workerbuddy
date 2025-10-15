import 'dart:async';

import 'package:dio/dio.dart';

/// Retry interceptor to retry failed api requests
class RetryInterceptor extends Interceptor {
  final Dio _dio;
  final int _maxRetryAttempts = 4;

  RetryInterceptor(this._dio);

  /// Check if a request should be retried and pass the error to the handler.
  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(error)) {
      return _retryRequest(error, handler);
    }
    super.onError(error, handler);
  }

  // Determine if the request should be retried.
  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionError;
  }

  // Retry request with quadratic delay 2^retryCount
  Future<void> _retryRequest(DioException error, ErrorInterceptorHandler handler) async {
    final requestOptions = error.requestOptions;
    int retryCount = requestOptions.extra['retryCount'] ?? 0;

    if (retryCount < _maxRetryAttempts) {
      await Future.delayed(Duration(seconds: (2 ^ retryCount)));
      requestOptions.extra['retryCount'] = retryCount + 1;

      try {
        final response = await _dio.fetch(requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.reject(e as DioException);
      }
    }
  }
}
