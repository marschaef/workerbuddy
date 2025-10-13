import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';



// Password manager for user database

// Generate hash from user password, unique user salt and static server salt
String generateHash(String password, String userSalt) {
  const String serverSalt = String.fromEnvironment(
    'SERVER_SALT',
    defaultValue: "0123456789abcdef0123456789abcdef",
  );
  return sha256.convert(utf8.encode(password + userSalt + serverSalt)).toString();
}

// Generate new hash from user password
(String, String) newHash(String password) {
  final userSalt = generateSalt();
  return (generateHash(password, userSalt), userSalt);
}

// Generate random 16 byte hex string
String generateSalt() {
  var random = Random.secure();
  final saltBytes = List<int>.generate(16, (i) => random.nextInt(256));
  return saltBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}

// Verify user passwort
Future<bool> verifyPassword(String userHash, String password) async {
  try {
    final userSalt = userHash.substring(0, 32);
    final hash = generateHash(password, userSalt);
    return hash == userHash.substring(32);
  } catch (e) {
    print("Error verify password: ${e.toString()}");
  }
  return false;
}
