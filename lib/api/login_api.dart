/*import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:crypto/crypto.dart';

void main() async {
  final router = Router();

  var handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router);

  var server = await io.serve(handler, 'localhost', 8080);
  print('Server läuft auf http://${server.address.host}:${server.port}');
}

final Map<String, String> users = {
  // Beispieluser, Passwörter besser gehasht speichern
  'user@example.com': 'geheimespasswort',
};

Future<Response> _router(Request request) async {
  if (request.method == 'POST' && request.url.path == 'api/login') {
    var payload = await request.readAsString();
    var data = json.decode(payload) as Map<String, dynamic>;

    String? email = data['email'];
    String? password = data['password'];

    if (email == null || password == null) {
      return Response(
        400,
        body: json.encode({'message': 'Email und Passwort erforderlich'}),
        headers: {'Content-Type': 'application/json'},
      );
    }

    if (users[email] == password) {
      // Token als simple Base64-Codierung (Beispiel, nicht für Produktion)
      String token = base64Encode(utf8.encode('$email:${DateTime.now()}'));

      return Response(
        200,
        body: json.encode({'token': token}),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      return Response(
        401,
        body: json.encode({'message': 'Ungültige E-Mail oder Passwort'}),
        headers: {'Content-Type': 'application/json'},
      );
    }
  }
  return Response.notFound('Nicht gefunden');
}
*/