// JWT token service to save, get, and delete auth tokens
class TokenService {
  // Private constructor to get single instance class
  TokenService._privateConstructor();
  static final TokenService instance = TokenService._privateConstructor();

  final Map<String, String?> _storage = {};

  // Save access token
  Future<void> saveAccessToken(String token) async {
    _storage['access'] = token;
  }

  // Save refresh token
  Future<void> saveRefreshToken(String token) async {
    _storage['refresh'] = token;
  }

  // Get access token
  Future<String?> getAccessToken() async {
    return _storage['access'];
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    return _storage['refresh'];
  }

  // Delete access token
  Future<void> deleteAccessToken() async {
    _storage.remove('access');
  }

  // Delete refresh token
  Future<void> deleteRefreshToken() async {
    _storage.remove('refresh');
  }

  // Check if a access token is stored
  Future<bool> hasAccessToken() async {
    return _storage.containsKey('access');
  }

  // Check if a refresh token is stored
  Future<bool> hasRefreshToken() async {
    return _storage.containsKey('refresh');
  }

  // Check if a access or refresh token is stored
  Future<bool> hasToken() async {
    if (await hasAccessToken()) return true;
    return await hasRefreshToken();
  }
}
