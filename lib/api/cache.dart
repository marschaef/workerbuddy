import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

import '../error_handler.dart';

const TABLE_NAME = 'cache';

// App cache with sqlite database
class Cache {
  late Database _database;
  final List<String> _keys = [];

  Cache() {
    WidgetsFlutterBinding.ensureInitialized();
    // Connect to database an create cache table
    Future<void> connectDB() async {
      _database = await openDatabase('${await getDatabasesPath()}.$TABLE_NAME.db');

      await _database.execute('''
CREATE TABLE IF NOT EXISTS $TABLE_NAME ( 
  id INTEGER PRIMARY KEY, 
  timestamp INTEGER NOT NULL,
  key TEXT NOT NULL,
  value TEXT)
''');
      final results = await _database.rawQuery('SELECT key FROM $TABLE_NAME;');
      
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
  Future<Map<String, dynamic>?> get(String key) async {
    try {
      if (_keys.contains(key)) {
        final command = 'SELECT value FROM $TABLE_NAME WHERE key = "$key"';
        final result = await _database.query(command);

        if (result.isNotEmpty) {
          return json.decode(result.first.toString());
        }
      }
    } catch (e) {
      ErrorHandler.handle(Error(ErrorCode.cacheError, 'GET', e.toString()));
    }
    return null;
  }

  // Update or insert cache vaule in database
  Future<bool> update(String key, dynamic value) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      if (_keys.contains(key)) {
        final command =
            'UPDATE $TABLE_NAME SET timestamp = $timestamp, value = "$value" WHERE key = "$key"';

        await _database.execute(command);
      } else {
        await _database.insert(TABLE_NAME, {
          'timestamp': timestamp,
          'key': key,
          'value': "$value",
        });

        _keys.add(key);
      }

      return true;
    } catch (e) {
      ErrorHandler.handle(Error(ErrorCode.cacheError, 'UPDATE', e.toString()));
      return false;
    }
  }

  // Clear cache
  Future<bool> delete(String key) async {
    try {
      if (_keys.contains(key)) {
        await _database.execute('DELETE FROM $TABLE_NAME WHERE key="$key"');
      }

      return true;
    } catch (e) {
      ErrorHandler.handle(Error(ErrorCode.cacheError, 'DELETE', e.toString()));
      return false;
    }
  }

  // Clear cache
  Future<bool> clear() async {
    try {
      await _database.execute('DELETE FROM $TABLE_NAME WHERE 1=1');
      return true;
    } catch (e) {
      ErrorHandler.handle(Error(ErrorCode.cacheError, 'CLEAR', e.toString()));
      return false;
    }
  }
}
