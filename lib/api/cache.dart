import 'dart:convert';

import 'package:sqflite/sqflite.dart';

const _TABLE_NAME = 'cache';

// App cache with sqlite
class Cache {
  late Database _database;
  final List<String> _keys = [];

  Cache() {
    // Connect to database an create cache table
    Future<void> connectDB() async {
      _database = await openDatabase('.$_TABLE_NAME.db');

      await _database.execute('''
CREATE TABLE IF NOT EXISTS $_TABLE_NAME ( 
  id INTEGER PRIMARY KEY, 
  timestamp INTEGER NOT NULL,
  key TEXT NOT NULL,
  value TEXT)
''');
      final results = await _database.query('SELECT key FROM cache');

      if (results.isNotEmpty) {
        for (var result in results) {
          if (result['key'] != null) {
            _keys.add(result['key'].toString());
          }
        }
      }
    }

    connectDB();
  }

  // Get cache value from database
  Future<dynamic> getCache(String key) async {
    try {
      if (_keys.contains(key)) {
        final command = 'SELECT value FROM $_TABLE_NAME WHERE key = "$key"';
        final result = await _database.query(command);

        if (result.isNotEmpty) {
          if (_shouldDelete(key)) {
            await _database.execute('DELETE FROM $_TABLE_NAME WHERE key = "$key"');
          }
          return json.decode(result.first.toString());
        }
      }
    } catch (e) {
      print('Error sqlite get $key cache: ${e.toString()}');
    }
    return null;
  }

  // Update or insert cache vaule in database
  Future<bool> updateCache(String key, String? value) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      if (_keys.contains(key)) {
        value = value == null ? 'NULL' : '"value"';
        final command =
            'UPDATE $_TABLE_NAME SET timestamp = $timestamp, value = $value WHERE key = "$key"';

        await _database.execute(command);
      } else {
        await _database.insert(_TABLE_NAME, {
          'timestamp': timestamp,
          'key': key,
          'value': value,
        });

        _keys.add(key);
      }

      return true;
    } catch (e) {
      print('Error sqlite update $key cache: ${e.toString()}');
      return false;
    }
  }

  // Determine if cached data should be deleted after first read
  bool _shouldDelete(String key) {
    return key == 'acceptOrder';
  }
}
