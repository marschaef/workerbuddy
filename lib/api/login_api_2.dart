import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:jaguar_jwt/jaguar_jwt.dart';

// Geheimschlüssel zum Signieren der JWTs (in Produktion sicher verwahren)
const String jwtSecret = 'deinGeheimerJWTKey';

// Benutzer-Beispieldaten (normalerweise aus DB)
final Map<String, String> users = {'user@example.com': 'geheimespasswort'};

void main() async {
  final router = Router();

  router.post('/api/login', (Request request) async {
    final payload = await request.readAsString();
    final data = json.decode(payload) as Map<String, dynamic>;
    final email = data['email'] as String?;
    final password = data['password'] as String?;

    if (email == null || password == null) {
      return Response(
        400,
        body: json.encode({'message': 'Email und Passwort erforderlich'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    if (users[email] == password) {
      final claimSet = JwtClaim(
        subject: email,
        issuer: 'deinServer',
        issuedAt: DateTime.now(),
        expiry: DateTime.now().add(Duration(hours: 1)),
        otherClaims: <String, dynamic>{'email': email},
        maxAge: const Duration(hours: 1),
      );

      final token = issueJwtHS256(claimSet, jwtSecret);

      return Response.ok(
        json.encode({'token': token}),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      return Response(
        401,
        body: json.encode({'message': 'Ungültige E-Mail oder Passwort'}),
        headers: {'Content-Type': 'application/json'},
      );
    }
  });

  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  await io.serve(handler, 'localhost', 8080);

  print('Server läuft auf http://localhost:8080');
}
