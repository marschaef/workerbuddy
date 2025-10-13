import 'package:shelf/shelf.dart';

const List<String>? ORIGINS = null;

const ACCESS_CONTROL_ALLOW_ORIGIN = 'Access-Control-Allow-Origin';

Map<String, String?> _defaultHeaders = {
  'Access-Control-Allow-Origin': null,
  'Access-Control-Expose-Headers': '',
  'Access-Control-Allow-Credentials': 'true',
  'Access-Control-Allow-Headers':
      'accept,accept-encoding,authorization,content-type,dnt,origin,user-agent',
  'Access-Control-Allow-Methods': 'OPTIONS,POST', // DELETE GET PATCH PUT UPDATE
  'Access-Control-Max-Age': '86400',
};

final _defaultHeadersAll = _defaultHeaders.map((key, value) => MapEntry(key, [value]));

Middleware corsHeaders() {
  return (Handler handler) {
    return (Request request) async {
      final origin = request.headers['origin'];

      if (origin == null || (ORIGINS != null && !ORIGINS!.contains(origin))) {
        return handler(request);
      }

      final headers = _defaultHeadersAll;

      final userProvidedAccessControlAllowOrigin = _defaultHeaders[ACCESS_CONTROL_ALLOW_ORIGIN];

      if (userProvidedAccessControlAllowOrigin != null) {
        headers[ACCESS_CONTROL_ALLOW_ORIGIN] = [userProvidedAccessControlAllowOrigin];
        headers['Vary'] = ['Origin'];
      } else {
        headers[ACCESS_CONTROL_ALLOW_ORIGIN] = [origin];
      }

      if (request.method == 'OPTIONS') {
        return Response.ok(null, headers: headers);
      }

      final response = await handler(request);

      return response.change(
        headers: {
          ...headers,
          ...response.headersAll,
        },
      );
    };
  };
}
