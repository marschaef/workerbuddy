import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'api.dart';
import 'middlewares/auth.dart';
import 'middlewares/cors.dart';
import 'middlewares/error.dart';

// API server with Shelf (start server: dart run server.dart)
void main() async {
  final api = Api();

  // Create middleware pipeline
  final handler = Pipeline()
      .addMiddleware(logRequests()) // Request logging
      .addMiddleware(corsHeaders()) // CORS settings
      .addMiddleware(jwtAuthHandler()) // JWT Authentification handler
      .addMiddleware(errorHandler()) // error handler
      .addHandler(api.router.call);

  // Start production server
  final server = await shelf_io.serve(
    handler,
    InternetAddress.anyIPv4,
    int.fromEnvironment('PORT', defaultValue: 8080),
  );

  print(
    'API server running on http://${server.address.host}:${server.port}',
  );
  print('Available endpoints:');
  print('  POST  /api/login');
  print('  POST  /api/logout');
  print('  POST  /api/register');
  print('  POST  /api/refresh');
  print('  POST  /api/acceptJob');
  print('  POST  /api/cancelJob');
  print('  POST  /api/jobs');
  print('  POST  /api/newJob');
  print('  POST  /api/updateJob');
  print('  POST  /api/finishJob');
  print('  POST  /api/users');
  print('  POST  /api/updateUser');
}
