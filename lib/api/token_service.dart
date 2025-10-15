import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// JWT token service to save, get, and delete tokens
class TokenService {
  // Private constructor to get single instance class
  TokenService._privateConstructor();
  static final TokenService instance = TokenService._privateConstructor();

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Save access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'jwt-access', value: token);
  }

  // Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: 'jwt-refresh', value: token);
  }

  // Get access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'jwt-access');
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'jwt-refresh');
  }

  // Delete access token
  Future<void> deleteAccessToken() async {
    await _storage.delete(key: 'jwt-access');
  }

  // Delete refresh token
  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: 'jwt-refresh');
  }

  // Check if a access token is stored
  Future<bool> hasAccessToken() async {
    return await _storage.containsKey(key: 'jwt-access');
  }

  // Check if a refresh token is stored
  Future<bool> hasRefreshToken() async {
    return await _storage.containsKey(key: 'jwt-refresh');
  }

  // Check if a access or refresh token is stored
  Future<bool> hasToken() async {
    if (await hasAccessToken()) return true;
    return await hasRefreshToken();
  }
}
