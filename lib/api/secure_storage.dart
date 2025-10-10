import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Private Konstruktor
  SecureStorageService._privateConstructor();

  // Die einzige Instanz
  static final SecureStorageService instance =
      SecureStorageService._privateConstructor();

  // Die Storage-Instanz
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Speichern eines Tokens
  Future<void> writeToken(String token) async {
    await _storage.write(key: 'jwt', value: token);
  }

  // Auslesen eines Tokens
  Future<String?> readToken() async {
    return await _storage.read(key: 'jwt');
  }

  // Löschen eines Tokens
  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt');
  }

  // Prüfen, ob Token existiert
  Future<bool> hasToken() async {
    return await _storage.containsKey(key: 'jwt');
  }

  // Alle Token löschen
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /*
  ----- VERWENDUNG -----

  final storage = SecureStorageService.instance;

  // Token speichern
  await storage.writeToken('MeinToken');

  // Token lesen
  String? token = await storage.readToken();

  // Token löschen
  await storage.deleteToken();
  */
}
