import 'dart:convert';

import 'package:shelf/shelf.dart';

Middleware errorHandler() {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        return await innerHandler(request);
      } catch (error, stackTrace) {
        // Log error details
        print('Error processing ${request.method} ${request.requestedUri}');
        print('Error: $error');
        print('Stack trace: $stackTrace');

        // Return generic error response
        return Response.internalServerError(
          body: jsonEncode({
            'error': 'Internal server error',
            'timestamp': DateTime.now().toIso8601String(),
            'path': request.requestedUri.path,
          }),

          headers: {'content-type': 'application/json'},
        );
      }
    };
  };
}
