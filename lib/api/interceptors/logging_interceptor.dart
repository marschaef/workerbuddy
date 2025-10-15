import 'package:dio/dio.dart';

/// Logging interceptor to log each api request
class LoggingInterceptor extends Interceptor {
  /// Log the HTTP method and the request path.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  /// Log the status code and the request path.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  /// Log the error status code and the request path.
  @override
  void onError(DioException error, ErrorInterceptorHandler handler) {
    print('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
    super.onError(error, handler);
  }
}
