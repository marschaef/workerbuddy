import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:worker_buddy/api/api_service.dart';

//Tests for client api service + api server methods
void main() {
  late Process p;

  final mail = 'test8@mail.com';
  final password = 'password';

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }
  databaseFactory = databaseFactoryFfi;

  final api = ApiService();

  // Run api server
  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'lib/api/server/server.dart'],
    );
    // Wait for server to start and print to stdout.
    await p.stdout.first;
  });

  tearDown(() => p.kill());
  
  // Test register method
  test('register', () async {
    final response = await api.register(
      "username",
      mail,
      password,
    );
    expect(response, isNotNull);
    expect(response?["email"], mail);
  });

  // Test logout method
  test('logout', () async {
    final response = await api.logout();
    expect(response, true);
  });

  // Test login method
  test('login', () async {
    final response = await api.login(mail, password);
    expect(response, isNotNull);
    expect(response?["email"], mail);
  });

  // Test refresh method
  test('refresh', () async {
    final response = await api.refreshToken();
    expect(response, true);
  });
  
}
