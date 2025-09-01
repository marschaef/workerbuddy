import 'package:crypto/crypto.dart';
import 'dart:convert';

// Methode zum Verschlüsseln des Passworts.
String encryptPassword(String passwort) {
  var bytes = utf8.encode(passwort);
  var hashedPasswort = sha256.convert(bytes).toString();
  return hashedPasswort;
}
