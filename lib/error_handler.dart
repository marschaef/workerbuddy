import 'package:dio/dio.dart';

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorised = 401; // failure, user is not authorised
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure, not found
  static const int invalidData = 422; // failure, not found

  // local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int locationDenied = -7;
  static const int defaultError = -8;
  static const int connectionError = -9;
  static const int apiError = -10;
}

// App error handler
class Error implements Exception {
  final int code;
  final String message;

  Error(this.code, this.message);

  @override
  String toString() => 'ERROR $code: $message';
}

class ApiException extends Error {
  final String method;

  ApiException(this.method, super.code, super.message);

  @override
  toString() {
    return 'ERROR $code $method: $message';
  }
}

// App error handler
class ErrorHandler {
  late Error error;

  ErrorHandler.handle(dynamic e) {
    if (e is DioException) {
      error = _handleDioError(e);
    } else if (e is ApiException) {
      error = Error(ResponseCode.apiError, e.toString());
    } else {
      error = ApiException("", ResponseCode.defaultError, e.toString());
    }
    print(error.toString());
  }

  Error _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Error(ResponseCode.connectTimeout, "Connection time out");
      case DioExceptionType.sendTimeout:
        return Error(ResponseCode.sendTimeout, "Api call time out");
      case DioExceptionType.receiveTimeout:
        return Error(ResponseCode.receiveTimeout, "Api time out received");
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.cancel:
        return Error(ResponseCode.cancel, "Api call canceled from server");
      case DioExceptionType.connectionError:
        return Error(ResponseCode.connectionError, "Connection failed");
      default:
        return _handleDefaultDioError(error);
    }
  }

  Error _handleBadResponse(DioException error) {
    try {
      final code = error.response?.statusCode ?? ResponseCode.defaultError;
      String message = '';
      switch (code) {
        case ResponseCode.unauthorised:
          return Error(code, "Unauthorized api call");
        case ResponseCode.forbidden:
          return Error(code, "Forbidden api call");
        case ResponseCode.notFound:
          return Error(code, "Url not found");
        default:
          message = error.response?.data;
          return Error(code, message);
      }
    } catch (e) {
      return Error(ResponseCode.defaultError, "Something went wrong");
    }
  }

  Error _handleDefaultDioError(dynamic error) {
    if (error.response?.statusCode == ResponseCode.noInternetConnection) {
      return Error(
        ResponseCode.noInternetConnection,
        "Please check your internet connection",
      );
    } else {
      return Error(ResponseCode.defaultError, "Something went wrong");
    }
  }
}
