import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

import 'database.dart';
import 'password_utils.dart';
import 'jwt_utils.dart';

class ApiMethod {
  static const String login = 'login';
  static const String logout = 'logout';
  static const String register = 'register';
  static const String refresh = 'refresh';
  
  static const String jobs = 'jobs';
  static const String acceptJob = 'acceptJob';
  static const String cancelJob = 'cancelJob';
  static const String newJob = 'newJob';
  static const String removeJob = 'removeJob';
  static const String updateJob = 'updateJob';

  static const String users = 'users';
  static const String updateUser = 'updateUser';
}

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
        final userID = user["id"];
        final userHash = await _database.getUserHash(userID);

        if (userHash != null) {
          if (await verifyPassword(userHash, body["password"])) {
            final accessToken = generateAccessToken(userID);
            final refreshToken = generateRefreshToken(userID);
            return _successResponse({
              'tokens': {'access': accessToken, 'refresh': refreshToken},
              'user': {},
            });
          }
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
      final body = json.decode(await request.readAsString());
      final success = await _database.updateUser(body["userId"], {"logged": false});

      return _successResponse(success);
    } catch (e) {
      print("Error api logout user: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Register new user api function
  Future<Response> _registerUser(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      final (userHash, userSalt) = newHash(body["password"]);
      body["user"]["hash"] = userHash;
      body["user"]["salt"] = userSalt;
      final userID = await _database.insertUser(body["user"]);

      if (userID != null) {
        final accessToken = generateAccessToken(userID);
        final refreshToken = generateRefreshToken(userID);
        return _successResponse({
          'tokens': {'access': accessToken, 'refresh': refreshToken},
          'user': {},
        });
      }
    } catch (e) {
      print("Error api new user: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Returns refreshed access and refresh jwt token to user
  Future<Response> _refreshToken(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      final userID = body["user"];

      if (userID != null) {
        final accessToken = generateAccessToken(userID);
        final refreshToken = generateRefreshToken(userID);
        return _successResponse({
          'tokens': {'access': accessToken, 'refresh': refreshToken},
        });
      }
    } catch (e) {
      print("Error api refresh token: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Accept job api function
  Future<Response> _acceptJob(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      //if (!_verifyToken(body["token"])) return _forbiddenResponse();
      final success = await _database.acceptJob(body["id"], body["user"]);

      return _successResponse(success);
    } catch (e) {
      print("Error api accept job: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Cancel job api function
  Future<Response> _cancelJob(Request request) async {
    try {
      final body = json.decode(await request.readAsString());

      final success = await _database.cancelJob(body["id"]);
      return _successResponse(success);
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
      final success = await _database.updateJob(body["id"], body["update"]);

      return _successResponse(success);
    } catch (e) {
      print("Error api update job: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Remove job api function
  Future<Response> _removeJob(Request request) async {
    try {
      final body = json.decode(await request.readAsString());
      final success = await _database.removeJob(body["id"]);

      return _successResponse(success);
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
      final success = await _database.updateUser(body["id"], body["update"]);

      return _successResponse(success);
    } catch (e) {
      print("Error api update user: ${e.toString()}");
    }
    return _badResponse(null);
  }

  // Returns success 200 response
  Response _successResponse(dynamic value) {
    return Response.ok(
      '{"value": $value, "timestamp": "${DateTime.now().toIso8601String()}"}',
      headers: {'content-type': 'application/json'},
    );
  }

  // Returns bad response 400 response
  Response _badResponse(String? error) {
    final message = error ?? "Bad Request";
    return Response.badRequest(
      body: '{"error": $message, "timestamp": "${DateTime.now().toIso8601String()}"}',
      headers: {'content-type': 'application/json'},
    );
  }
}
