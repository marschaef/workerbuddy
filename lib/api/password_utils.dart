import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

import 'package:pointycastle/asymmetric/api.dart';

// Password utils functions to generate salted hashes

const TEST_RSA_PUBLIC = '''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArHgWkfjycp41WHDF/EELpyCzVSOIsmTTtdNtkvx1nsmRKzJc2h+NICN5pEu095ql34Z3Zgb4teMJULBMrSxwJW0xWbvaw6jy8GYNldQ0djSrxCwtZuUYWrQ5sz5yfDy5NjuJnaQmn3ng+ZUP+7Y+/kr8Kfb7Wwb6MGQPjFZKkMQIQppgqX/OOrxofqJ+QPIC2e1tEZnXQyPEKtcec7yXyx5TroPMrkKTnCKwfJ6VupZ/GEEOOzBQ46gNdO6avMihreMJrvr63DBkzfgxyhL5wMT2CZuJ+H7zvnHBTbnb+9mdwI2l1lGdj8T/AoTH7xPedJMDezibW40yGvd86OJlkQIDAQAB
-----END PUBLIC KEY-----''';

// Generate RSA256 encrypted salted password
String encryptedHash(String password) {
  return _encryptRSA(_generateHash(password));
}

// Generate sha256 from user password + static salt
String _generateHash(String password) {
  const String salt = String.fromEnvironment(
    'SERVER_SALT',
    defaultValue: "0123456789abcdef",
  );
  return sha256.convert(utf8.encode(password + salt)).toString();
}


// RSA data encryption
String _encryptRSA(String data) {
  //if(data.length > 180) return null;
  final parser = RSAKeyParser();
  final encrypter = Encrypter(RSA(
    publicKey: parser.parse(
      String.fromEnvironment('RSA_PUBLIC', defaultValue: TEST_RSA_PUBLIC)
    ) as RSAPublicKey,
    encoding: RSAEncoding.OAEP,
    digest: RSADigest.SHA256
  ));
  return encrypter.encrypt(data).base64;
}
