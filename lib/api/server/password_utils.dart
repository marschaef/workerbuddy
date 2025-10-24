import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

import 'package:pointycastle/asymmetric/api.dart';

// Password utils functions to generate salts and hashes

const TEST_RSA_PRIVATE = '''-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCseBaR+PJynjVYcMX8QQunILNVI4iyZNO1022S/HWeyZErMlzaH40gI3mkS7T3mqXfhndmBvi14wlQsEytLHAlbTFZu9rDqPLwZg2V1DR2NKvELC1m5RhatDmzPnJ8PLk2O4mdpCafeeD5lQ/7tj7+Svwp9vtbBvowZA+MVkqQxAhCmmCpf846vGh+on5A8gLZ7W0RmddDI8Qq1x5zvJfLHlOug8yuQpOcIrB8npW6ln8YQQ47MFDjqA107pq8yKGt4wmu+vrcMGTN+DHKEvnAxPYJm4n4fvO+ccFNudv72Z3AjaXWUZ2PxP8ChMfvE950kwN7OJtbjTIa93zo4mWRAgMBAAECggEABKzYa4QI34SpULvkRC14z6ked6QYBEI6o3w5Vk7zydEQLL9TalyrQeIrxBsLZu0AIhcJ++/otYE+TLvHgv1w272IaXj4Swejif2HA/LeQ9xu/J6iwLOPyj9CCsHWES1rr1bMwpirvgXjf5w7Wq9r5KjLLA1hGVLb5Vk/9uou2BH9+RQc6pStXA9OkVHLMlDlfoltQPiFYcaUOKS/+b4DzLf5syFqCQCG0avjNBDdXGvV7fyZVld5N6HarGI797Ywi1FHo5eqd89Gzey2rCfFPlKjb1juqwJ6RG1tC3i/DvaDSksSPCCRXN70oYyyYY+p/0YCDta7WlPyPXObzT4RIQKBgQDIEhLa40wysv2vVbaMH6SxT8NmWKgqO8jpdJzRn0GFgxlPrb5TT2KWEx2ts7w8Ph9Jrmg7+LpOyP7ePsfqfgmRBKCHbWqGmg71oK3wtG8oddPZKwSxweWiDkxRAF5PXDZBqi5W9GWgOPXNH3fHuQetiWGAbHOGbpI18j/IKkzh4wKBgQDcrrrrVSaNDWm6h6FcmF+jFh3gBuMUmqadCI1KNCVZcDVG9Mtqfz7ajrN1TbdWHIiL14mHXVHfpheZN12C7amCV2DTBN+CPpMR+OgkI58BN4PNzuWFfQ/9ToJfkolzYW3aKkhx478pSMatoCZ843FHb7BIVatAHlg9+Zvbqd8k+wKBgEL/GmVGHCwWGDFwqHJ/3iyqIyrQoW+TGZJjxGfFxrEo138BFWzcdoz+1b9nIq+hteR8jNcYUXs0f3R43YU+s4FmZUM0dqmgSUYjilvCcD7CRjDA4Q+NeJIt64xsbShyHpEape3kZWuj51vLH9c3tMR97rKMnprzx+5cstMapyg1AoGAfG6FdNZBc30hpYx+XrCIFHQPCle3yNFequK8kB+RA7oyQD0dSYJQFXorFDRq8MIL+BXjNRFYbevAGKNQNdf+IUFVlgaEZHMWCCc59c6kBFKiHfTQFBGtZ13SQ0Nj/0vrXf1Ddfw9uHCRnirUKM0x/V6rnk23zuKNTPymdhh1eusCgYEAhOk3dx5jVoJczvITJvhBQQVELMysAPflyTVnq6FqpRPAVRw/jRgBAzoKfZijBDOGnuZzriaSVFD5cARaGLDdIzIv1k1t/rcGTRrTwM8QcbB0kDsVI/Mhfmzyh4zOGaPD4BTdly3//lLmWZhj+XuBkoFTVx8vVm9lMKmvnvFzeog=
-----END RSA PRIVATE KEY-----''';

// Generate sha256 from password + salt
String generateHash(String password) {
  return _generateHash(password, _generateSalt());
}

// Verify user passwort
bool verifyHash(String userHash, String password) {
  try {
    final userSalt = userHash.substring(0, 16);
    final hash = _generateHash(password, userSalt);
    
    return hash == userHash;
  } catch (e) {
    print("Error verify password: ${e.toString()}");
  }
  return false;
}

// Generate sha256 from password + salt
String _generateHash(String password, String salt) {
  return '$salt${sha256.convert(utf8.encode(_decryptRSA(password) + salt)).toString()}';
}

// Generate random 8 byte hex string
String _generateSalt() {
  var random = Random.secure();
  final saltBytes = List<int>.generate(8, (i) => random.nextInt(256));
  return saltBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}

// RSA data decryption
String _decryptRSA(String data) {
  final parser = RSAKeyParser();
  final decrypter = Encrypter(RSA(
    privateKey: parser.parse(
      String.fromEnvironment('RSA_PRIVATE', defaultValue: TEST_RSA_PRIVATE)
    ) as RSAPrivateKey ,
    encoding: RSAEncoding.OAEP,digest: RSADigest.SHA256
  ));
  return decrypter.decrypt(Encrypted.fromBase64(data)).toString();
}
