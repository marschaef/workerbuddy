import 'package:shelf/shelf.dart';

import '../jwt_utils.dart';

// Custom authentication middleware
Middleware jwtAuthHandler() {
  return (Handler innerHandler) {
    return (Request request) async {
      // Skip auth for login
      if (request.url.path == 'login') return innerHandler(request);

      final authHeader = request.headers['authorization'];

      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response.unauthorized(
          '{"error": "Authentication required"}',
          headers: {'content-type': 'application/json'},
        );
      }

      final token = authHeader.substring(7); // Remove 'Bearer ' prefix

      // Validate jwt token
      String? error = verifyToken(token);
      if (error != null) {
        return Response.unauthorized(
          '{"error": "$error"}',
          headers: {'content-type': 'application/json'},
        );
      }

      // Add user to request
      final updatedRequest = request.change(
        context: {'userId': getUserFromToken(token)},
      );

      return innerHandler(updatedRequest);
    };
  };
}
