import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

import 'database.dart';
import 'password_utils.dart';
import 'jwt_utils.dart';

class Api {
  final AppDatabase _database = AppDatabase();
  //final PasswordManager _passwordManager = PasswordManager.instance;

  shelf_router.Router get router {
    final router = shelf_router.Router();

    // POST api endpoints
    // Auth methods
    router.post('/api/login', _login);
    router.post('/api/logout', _logout);
    router.post('/api/register', _registerUser);
    router.post('/api/refresh', _refreshToken);
    // Job methods
    router.post('/api/acceptJob', _acceptJob);
    router.post('/api/cancelJob', _cancelJob);
    router.post('/api/jobs', _getJobs);
    router.post('/api/newJob', _newJob);
    router.post('/api/removeJob', _removeJob);
    router.post('/api/updateJob', _updateJob);
    // User methods
    router.post('/api/users', _getUsers);
    router.post('/api/updateUser', _updateUser);

    return router;
  }

  // Returns access and refresh jwt token to user
  Future<Response> _login(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      final user = await _database.getUserWithMail(body["email"]);
      if (user != null) {
        if (verifyHash(user["hash"], body["hash"])) {
          final userId = int.parse(user["id"]);
          final accessToken = generateAccessToken(userId);
          final refreshToken = generateRefreshToken(userId);

          return _loginResponse(
            {'id': userId, 'email': body["email"]},
            {'access': accessToken, 'refresh': refreshToken},
          );
        }
      }
    } catch (e) {
      print("Error api login: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Returns access and refresh jwt token to user
  Future<Response> _logout(Request request) async {
    try {
      //final userId = _getUserFromContext(request.context);
      //final success = await _database.updateUser(body["userId"], {"logged": false});
      return _successResponse(true);
    } catch (e) {
      print("Error api logout user: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Register new user api function
  Future<Response> _registerUser(Request request) async {
    String? error;
    try {
      final body = json.decode(await request.readAsString());
      if (await _database.getUserWithMail(body["email"]) == null) {
        body["hash"] = generateHash(body["hash"]);
        final userId = await _database.insertUser(body);

        if (userId != null) {
          final accessToken = generateAccessToken(userId);
          final refreshToken = generateRefreshToken(userId);

          return _loginResponse(
            {'id': userId, 'email': body["email"]},
            {'access': accessToken, 'refresh': refreshToken},
          );
        }
      } else {
        error = 'Email already in use';
      }
    } catch (e) {
      print("Error api new user: ${e.toString()}");
    }
    return _badResponse(error);
  }

  // Returns refreshed access and refresh jwt token to user
  Future<Response> _refreshToken(Request request) async {
    try {
      final userId = _getUserFromContext(request.context);
      final accessToken = generateAccessToken(userId);
      final refreshToken = generateRefreshToken(userId);

      return _loginResponse(true, {
        'access': accessToken,
        'refresh': refreshToken,
      });
    } catch (e) {
      print("Error api refresh token: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Accept job api function
  Future<Response> _acceptJob(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      final userId = _getUserFromContext(request.context);

      if (await _database.isWorker(userId)) {
        final success = await _database.acceptJob(userId, body["user"]);
        return _successResponse(success);
      }
    } catch (e) {
      print("Error api accept job: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Cancel job api function
  Future<Response> _cancelJob(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      final userId = _getUserFromContext(request.context);
      final jobId = body["id"];

      if (await _database.isUsersJob(jobId, userId)) {
        final success = await _database.cancelJob(jobId);
        return _successResponse(success);
      }
    } catch (e) {
      print("Error api remove job: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Get jobs api function
  Future<Response> _getJobs(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      final values = await _database.getJobs(
        body.containsKey("filter") ? body["filter"] : null,
      );

      if (values != null) return _successResponse(values);
    } catch (e) {
      print("Error api get jobs: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // New job api function
  Future<Response> _newJob(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      final rowId = await _database.insertJob(body["job"]);

      if (rowId != null) return _successResponse(rowId);
    } catch (e) {
      print("Error api new job: ${e.toString()}");
    }

    return _badResponse(null);
  }

  // Update job api function
  Future<Response> _updateJob(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      final userId = _getUserFromContext(request.context);
      final jobId = body["id"];

      if (await _database.isUsersJob(jobId, userId)) {
        final success = await _database.updateJob(jobId, body["update"]);
        return _successResponse(success);
      }
    } catch (e) {
      print("Error api update job: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Remove job api function
  Future<Response> _removeJob(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      final userId = _getUserFromContext(request.context);
      final jobId = body["id"];

      if (await _database.isUsersJob(jobId, userId)) {
        final success = await _database.removeJob(body["id"]);
        return _successResponse(success);
      }
    } catch (e) {
      print("Error api remove job: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Get users api function
  Future<Response> _getUsers(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      final values = await _database.getUsers(
        body.containsKey("filter") ? body["filter"] : null,
      );

      if (values != null) return _successResponse(values);
    } catch (e) {
      print("Error api get users: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Update user api function
  Future<Response> _updateUser(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      final userId = _getUserFromContext(request.context);
      final success = await _database.updateUser(userId, body["update"]);

      return _successResponse(success);
    } catch (e) {
      print("Error api update user: ${e.toString()}");
    }
    return _badResponse(null);
  }

  int _getUserFromContext(Map<String, Object?> context) {
    return int.parse(context["userId"].toString());
  }

  // Returns success 200 response
  Response _successResponse(dynamic value) {
    return Response.ok(
      '{"value": ${json.encode(value)}, "timestamp": "${DateTime.now().toIso8601String()}"}',
      headers: {'content-type': 'application/json'},
    );
  }

  // Returns success 200 response with user data and auth tokens
  Response _loginResponse(dynamic value, Map tokens) {
    return Response.ok(
      '{"value": ${json.encode(value)}, "tokens": ${json.encode(tokens)}, "timestamp": "${DateTime.now().toIso8601String()}"}',
      headers: {'content-type': 'application/json'},
    );
  }

  // Returns bad response 400 response
  Response _badResponse(String? error) {
    final message = error ?? "Bad Request";
    return Response.badRequest(
      body: '{"error": "$message", "timestamp": "${DateTime.now().toIso8601String()}"}',
      headers: {'content-type': 'application/json'},
    );
  }
}
