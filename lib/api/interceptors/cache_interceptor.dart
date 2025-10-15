import 'package:dio/dio.dart';

import '../cache.dart';

/// Cache interceptor to cache success api responses
class CacheInterceptor extends Interceptor {
  final Cache _cache;

  CacheInterceptor(this._cache);

  /// Log the status code and the request path.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 200) {
      final data = response.data;
      if (data != null) {
        await _cache.updateCache(data["methode"], data);
      }
    }
    super.onResponse(response, handler);
  }
}
