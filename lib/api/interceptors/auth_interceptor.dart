import 'package:dio/dio.dart';

import '../token_service_test.dart';

/// Authorization interceptor to manage access tokens for api requests
class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final TokenService _tokenService;

  AuthInterceptor(this._dio, this._tokenService);

  /// Add access token to the headers of an api request.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String apiMethode = options.path.split('/').last;

    // Add headers to request
    options.headers.addAll({
      'Content-Type': 'application/json',
    });
    
    if (apiMethode != 'login' && apiMethode != 'register') {
      String? accessToken;
      final isRefresh = apiMethode == 'refresh';

      if (isRefresh) {
        accessToken = await _tokenService.getRefreshToken();
      } else {
        accessToken = await _tokenService.getAccessToken();
      }

      if (accessToken == null) {
        try {
          if (!isRefresh) {
            final response = await _refreshToken(options);
            if (response != null) return handler.resolve(response);
          }

          return handler.reject(
            DioException(requestOptions: options, message: 'No access token found'),
          );
        } catch (e) {
          // If refresh fails, refect request.
          return handler.reject(e as DioException);
        }
      }
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  /// Save tokens after token refresh, login or register.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    String method = response.realUri.toString().split('/').last;
    if ((method == 'refresh' || method == 'login' || method == 'register') &&
        response.statusCode == 200) {
      final data = response.data;
      _tokenService.saveAccessToken(data["tokens"]["access"]);
      _tokenService.saveRefreshToken(data["tokens"]["refresh"]);
    }

    super.onResponse(response, handler);
  }

  /// Refresh access token after failed authentification
  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {
      if (await _tokenService.getAccessToken() != null) {
        await _tokenService.deleteAccessToken();
      } else if (await _tokenService.getRefreshToken() != null) {
        await _tokenService.deleteRefreshToken();
        super.onError(error, handler);
        return;
      }

      final refreshToken = await _tokenService.getRefreshToken();

      if (refreshToken != null) {
        final response = await _refreshToken(error.requestOptions);
        if (response != null) return handler.resolve(response);
      }
    }
    super.onError(error, handler);
  }

  // Refresh access token
  Future<Response<dynamic>?> _refreshToken(RequestOptions options) async {
    try {
      final refreshToken = await _tokenService.getRefreshToken();
      if (refreshToken == null) return null;

      options.headers['Authorization'] = 'Bearer $refreshToken';

      final response = await _dio.request(
        "${_dio.options.baseUrl}/refresh",
        options: Options(
          method: options.method,
          headers: options.headers,
        ),
      );
      return response;
    } catch (e) {
      throw (e as DioException);
    }
  }
}
