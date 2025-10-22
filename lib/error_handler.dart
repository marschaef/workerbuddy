import 'package:dio/dio.dart';

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data
  static const int badRequest = 400; // API rejected request
  static const int unauthorised = 401; // user is not authorised
  static const int forbidden = 403; // forbidden request
  static const int internalServerError = 500; // crash in server side
  static const int notFound = 404; // not found
  static const int invalidData = 422; // invalid data
}

class ErrorCode {
  // local status code
  static const int unknown = 0;
  static const int connectTimeout = 1;
  static const int cancel = 2;
  static const int receiveTimeout = 3;
  static const int sendTimeout = 4;
  static const int cacheError = 5;
  static const int noInternetConnection = 6;
  static const int locationDenied = 7;
  static const int defaultError = 8;
  static const int connectionError = 9;
  static const int apiError = 10;
}

// Error class
class Error implements Exception {
  final int code;
  final String message;
  final String? method;

  Error(this.code, this.method, this.message);

  @override
  String toString() => 'ERROR $code $method: $message';
}

// App error handler
class ErrorHandler {
  late Error error;

  ErrorHandler.handle(dynamic e) {
    if (e is DioException) {
      error = _handleDioError(e);
    } else if (e is Error) {
      error = e;
    } else {
      error = Error(ErrorCode.unknown, null, e.toString());
    }
    print(error.toString());
  }

  // Dio client response errors
  Error _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Error(ErrorCode.connectTimeout, null, "Connection time out");
      case DioExceptionType.sendTimeout:
        return Error(ErrorCode.sendTimeout, null, "Api call time out");
      case DioExceptionType.receiveTimeout:
        return Error(ErrorCode.receiveTimeout, null, "Api time out received");
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.cancel:
        return Error(ErrorCode.cancel, null, "Api call canceled from server");
      case DioExceptionType.connectionError:
        return Error(ErrorCode.connectionError, null, "Connection failed");
      default:
        return _handleDefaultDioError(error);
    }
  }

  // Dio client bad responses
  Error _handleBadResponse(DioException error) {
    try {
      final code = error.response?.statusCode ?? ErrorCode.defaultError;
      switch (code) {
        case ResponseCode.unauthorised:
          return Error(code, null, "Unauthorized api call");
        case ResponseCode.forbidden:
          return Error(code, null, "Forbidden api call");
        case ResponseCode.notFound:
          return Error(code, null, "Url not found");
        default:
          return Error(code, null, error.response?.data);
      }
    } catch (e) {
      return Error(ErrorCode.defaultError, null, "Something went wrong");
    }
  }

  // Dio client default error
  Error _handleDefaultDioError(dynamic error) {
    if (error.response?.statusCode == ErrorCode.noInternetConnection) {
      return Error(
        ErrorCode.noInternetConnection,
        null,
        "Please check your internet connection",
      );
    } else {
      return Error(ErrorCode.defaultError, null, "Something went wrong");
    }
  }
}
