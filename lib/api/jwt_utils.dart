import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'dart:convert';

const _TEST_RSA_PUBLIC = '''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArHgWkfjycp41WHDF/EELpyCzVSOIsmTTtdNtkvx1nsmRKzJc2h+NICN5pEu095ql34Z3Zgb4teMJULBMrSxwJW0xWbvaw6jy8GYNldQ0djSrxCwtZuUYWrQ5sz5yfDy5NjuJnaQmn3ng+ZUP+7Y+/kr8Kfb7Wwb6MGQPjFZKkMQIQppgqX/OOrxofqJ+QPIC2e1tEZnXQyPEKtcec7yXyx5TroPMrkKTnCKwfJ6VupZ/GEEOOzBQ46gNdO6avMihreMJrvr63DBkzfgxyhL5wMT2CZuJ+H7zvnHBTbnb+9mdwI2l1lGdj8T/AoTH7xPedJMDezibW40yGvd86OJlkQIDAQAB
-----END PUBLIC KEY-----''';

const _TEST_RSA_PRIVATE = '''-----BEGIN RSA PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCseBaR+PJynjVYcMX8QQunILNVI4iyZNO1022S/HWeyZErMlzaH40gI3mkS7T3mqXfhndmBvi14wlQsEytLHAlbTFZu9rDqPLwZg2V1DR2NKvELC1m5RhatDmzPnJ8PLk2O4mdpCafeeD5lQ/7tj7+Svwp9vtbBvowZA+MVkqQxAhCmmCpf846vGh+on5A8gLZ7W0RmddDI8Qq1x5zvJfLHlOug8yuQpOcIrB8npW6ln8YQQ47MFDjqA107pq8yKGt4wmu+vrcMGTN+DHKEvnAxPYJm4n4fvO+ccFNudv72Z3AjaXWUZ2PxP8ChMfvE950kwN7OJtbjTIa93zo4mWRAgMBAAECggEABKzYa4QI34SpULvkRC14z6ked6QYBEI6o3w5Vk7zydEQLL9TalyrQeIrxBsLZu0AIhcJ++/otYE+TLvHgv1w272IaXj4Swejif2HA/LeQ9xu/J6iwLOPyj9CCsHWES1rr1bMwpirvgXjf5w7Wq9r5KjLLA1hGVLb5Vk/9uou2BH9+RQc6pStXA9OkVHLMlDlfoltQPiFYcaUOKS/+b4DzLf5syFqCQCG0avjNBDdXGvV7fyZVld5N6HarGI797Ywi1FHo5eqd89Gzey2rCfFPlKjb1juqwJ6RG1tC3i/DvaDSksSPCCRXN70oYyyYY+p/0YCDta7WlPyPXObzT4RIQKBgQDIEhLa40wysv2vVbaMH6SxT8NmWKgqO8jpdJzRn0GFgxlPrb5TT2KWEx2ts7w8Ph9Jrmg7+LpOyP7ePsfqfgmRBKCHbWqGmg71oK3wtG8oddPZKwSxweWiDkxRAF5PXDZBqi5W9GWgOPXNH3fHuQetiWGAbHOGbpI18j/IKkzh4wKBgQDcrrrrVSaNDWm6h6FcmF+jFh3gBuMUmqadCI1KNCVZcDVG9Mtqfz7ajrN1TbdWHIiL14mHXVHfpheZN12C7amCV2DTBN+CPpMR+OgkI58BN4PNzuWFfQ/9ToJfkolzYW3aKkhx478pSMatoCZ843FHb7BIVatAHlg9+Zvbqd8k+wKBgEL/GmVGHCwWGDFwqHJ/3iyqIyrQoW+TGZJjxGfFxrEo138BFWzcdoz+1b9nIq+hteR8jNcYUXs0f3R43YU+s4FmZUM0dqmgSUYjilvCcD7CRjDA4Q+NeJIt64xsbShyHpEape3kZWuj51vLH9c3tMR97rKMnprzx+5cstMapyg1AoGAfG6FdNZBc30hpYx+XrCIFHQPCle3yNFequK8kB+RA7oyQD0dSYJQFXorFDRq8MIL+BXjNRFYbevAGKNQNdf+IUFVlgaEZHMWCCc59c6kBFKiHfTQFBGtZ13SQ0Nj/0vrXf1Ddfw9uHCRnirUKM0x/V6rnk23zuKNTPymdhh1eusCgYEAhOk3dx5jVoJczvITJvhBQQVELMysAPflyTVnq6FqpRPAVRw/jRgBAzoKfZijBDOGnuZzriaSVFD5cARaGLDdIzIv1k1t/rcGTRrTwM8QcbB0kDsVI/Mhfmzyh4zOGaPD4BTdly3//lLmWZhj+XuBkoFTVx8vVm9lMKmvnvFzeog=
-----END RSA PRIVATE KEY-----''';

// JWT token service to generate and verify tokens

// Verify token
String? verifyToken(String token) {
  try {
    JWT.verify(
      token,
      SecretKey(String.fromEnvironment('RSA_PUBLIC', defaultValue: _TEST_RSA_PUBLIC)),
    );
    return null;
  } on JWTExpiredException {
    return 'Expired authentication token';
  } on JWTException catch (e) {
    print('Failed JWT authentication: ${e.toString()}');
    return 'Invalid authentication token'; // ex: invalid signature
  }
}

// Verify token
int? getUserFromToken(String token) {
  try {
    final jwt = JWT.decode(token);
    return json.decode(jwt.payload.toString())["userID"];
  } on JWTExpiredException {
    print('Expired authentication token');
  } on JWTException catch (e) {
    print('Failed JWT authentication: ${e.toString()}');
  }
  return null;
}

// Generate access token
String generateAccesToken(int userId) {
  final jwt = JWT(
    {
      'userID': userId,
      'server': {
        'id': 'workerbuddy',
        'loc': 'euw-2',
      },
    },
    issuer: 'workerbuddy',
  );
  return jwt.sign(
    SecretKey(String.fromEnvironment('RSA_PRIVATE', defaultValue: _TEST_RSA_PRIVATE)),
    algorithm: JWTAlgorithm.RS256,
    noIssueAt: false,
    expiresIn: Duration(minutes: 60),
  );
}

// Generate refresh token
String generateRefreshToken(int userId) {
  final jwt = JWT(
    {
      'userID': userId,
      'server': {
        'id': 'workerbuddy',
        'loc': 'euw-2',
      },
    },
    issuer: 'workerbuddy',
  );
  return jwt.sign(
    SecretKey(String.fromEnvironment('RSA_PRIVATE', defaultValue: _TEST_RSA_PRIVATE)),
    algorithm: JWTAlgorithm.RS256,
    noIssueAt: false,
    expiresIn: Duration(days: 7),
  );
}
