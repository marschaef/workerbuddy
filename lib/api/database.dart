import 'package:mysql_client/mysql_client.dart';

// Workerbuddy MySQL database interface
class AppDatabase {
  int jobCount = 0;
  int userCount = 0;
  late MySQLConnection _database;

  AppDatabase() {
    // Connect to database with environment variables configurable with --dart-define
    Future<void> connectDB() async {
      _database = await MySQLConnection.createConnection(
        host: String.fromEnvironment('MYSQL_HOST', defaultValue: '127.0.0.1'),
        port: int.fromEnvironment('MYSQL_PORT', defaultValue: 8080),
        userName: String.fromEnvironment('MYSQL_USERNAME', defaultValue: 'user'),
        password: String.fromEnvironment('MYSQL_PASSWORD', defaultValue: 'password'),
        databaseName: String.fromEnvironment(
          'MYSQL_APP_DATABASE',
          defaultValue: 'workerbuddy',
        ),
      );
      _database.connect();

      // Set maybe a short delay before querying
      //await Future.delayed(const Duration(milliseconds: 10));

      jobCount = (await getTableLength('jobs'))?.toInt() ?? jobCount;
      userCount = (await getTableLength('users'))?.toInt() ?? userCount;
    }

    connectDB();
  }

  // Generate MySQL Update command
  Future<BigInt?> getTableLength(String table) async {
    try {
      final command =
          "SELECT TABLE_ROWS FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'workerbuddy' AND TABLE_NAME = $table";
      final result = await _database.execute(command);
      if (result.rows.isNotEmpty) return BigInt.parse(result.rows.first.toString());
    } catch (e) {
      print("Error mysql get table length of $table: ${e.toString()}");
    }
    return null;
  }

  // Update job in mysql database
  Future<bool> acceptJob(int jobId, int userId) async {
    try {
      if (_validJobId(jobId) && _validJobId(userId)) {
        return await updateJob(jobId, {
          "worker": userId,
          "auftragAngenommen": DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      print("Error mysql accept job: ${e.toString()}");
    }
    return false;
  }

  // Cancel job from mysql database
  Future<bool> cancelJob(int id) async {
    try {
      if (_validJobId(id)) {
        final command = "DELETE FROM active WHERE id = $id";
        final result = await _database.execute(command);

        if (result.affectedRows > BigInt.from(0)) {
          return updateJob(id, {"active": false, "canceled": true});
        }
      }
    } catch (e) {
      print("Error mysql cancel job: ${e.toString()}");
    }
    return false;
  }

  // Finish job from mysql database
  Future<bool> finishJob(int id) async {
    try {
      if (_validJobId(id)) {
        final command = "DELETE FROM active WHERE id = $id";
        final result = await _database.execute(command);

        if (result.affectedRows > BigInt.from(0)) {
          return updateJob(id, {"istAbgeschlossen": true, "canceled": false});
        }
      }
    } catch (e) {
      print("Error mysql finish job: ${e.toString()}");
    }
    return false;
  }

  // Get job from mysql database
  Future<Map?> getJob(int id) async {
    try {
      if (_validJobId(id)) {
        final command = "SELECT * FROM jobs WHERE id = $id";
        final result = await _database.execute(command);

        if (result.rows.isNotEmpty) return result.rows.first.assoc();
      }
    } catch (e) {
      print("Error mysql get job: ${e.toString()}");
    }
    return null;
  }

  // Get jobs from mysql database
  Future<List<Map>?> getJobs(Map? filter) async {
    try {
      var command = "SELECT * FROM jobs";

      if (filter != null) {
        const filterKeys = ["time", "city"];
        command += _generateConditions(filterKeys, filter);
      }

      List<Map>? values;
      final result = await _database.execute(command);

      if (result.rows.isNotEmpty) {
        values = [];
        for (var row in result.rows) {
          values.add(row.assoc());
        }
      }

      return values;
    } catch (e) {
      print("Error mysql get jobs: ${e.toString()}");
      return null;
    }
  }

  // Insert job into mysql database
  Future<int?> insertJob(Map job) async {
    try {
      final command = await _insertCommand('jobs', true, job);
      final result = await _database.execute(command);

      if (result.isNotEmpty) {
        jobCount = result.lastInsertID.toInt();
        return jobCount;
      }
    } catch (e) {
      print("Error mysql insert job: ${e.toString()}");
    }
    return null;
  }

  // Update job in mysql database
  Future<bool> updateJob(int id, Map update) async {
    try {
      if (_validJobId(id)) {
        const updateKeys = ["time", "active"];
        final command = "${_updateCommand('jobs', updateKeys, update)} WHERE id = $id";
        final result = await _database.execute(command);

        if (!result.affectedRows.isNegative) return true;
      }
    } catch (e) {
      print("Error mysql update job: ${e.toString()}");
    }
    return false;
  }

  // Delete job from mysql database
  Future<bool> removeJob(int id) async {
    try {
      if (_validJobId(id)) {
        final command = "DELETE FROM active WHERE id = $id";
        final result = await _database.execute(command);

        if (result.affectedRows > BigInt.from(0)) {
          return await updateJob(id, {"active": false});
        }
      }
    } catch (e) {
      print("Error mysql remove job: ${e.toString()}");
    }
    return false;
  }

  // Get user from mysql database
  Future<int?> getUserID(String email) async {
    try {
      final results = await getUsers({'email': email});
      if (results != null) {
        return results[0]["id"];
      }
    } catch (e) {
      print("Error mysql get user id: ${e.toString()}");
    }
    return null;
  }

  // Get user from mysql database
  Future<Map?> getUser(int id) async {
    try {
      if (_validUserId(id)) {
        final command = "SELECT * FROM users WHERE id = $id";
        final result = await _database.execute(command);

        if (result.rows.isNotEmpty) return result.rows.first.assoc();
      }
    } catch (e) {
      print("Error mysql get user: ${e.toString()}");
    }
    return null;
  }

  // Get user from mysql database
  Future<String?> getUserHash(int id) async {
    try {
      final command = "SELECT hash FROM users WHERE id = $id";
      final result = await _database.execute(command);

      if (result.rows.isNotEmpty) return result.rows.first.assoc()["hash"];
    } catch (e) {
      print("Error mysql get user with mail: ${e.toString()}");
    }
    return null;
  }

  // Get user from mysql database
  Future<Map?> getUserWithMail(String email) async {
    try {
      final command = "SELECT * FROM users WHERE email = $email";
      final result = await _database.execute(command);

      if (result.rows.isNotEmpty) return result.rows.first.assoc();
    } catch (e) {
      print("Error mysql get user with mail: ${e.toString()}");
    }
    return null;
  }

  // Get users from mysql database
  Future<List<Map>?> getUsers(Map? filter) async {
    try {
      var command = "SELECT * FROM users";

      if (filter != null) {
        const filterKeys = ["id", "name"];
        command += _generateConditions(filterKeys, filter);
      }

      List<Map>? values;
      final result = await _database.execute(command);

      if (result.rows.isNotEmpty) {
        values = [];
        for (var row in result.rows) {
          values.add(row.assoc());
        }
      }

      return values;
    } catch (e) {
      print("Error mysql get users: ${e.toString()}");
      return null;
    }
  }

  // Insert user into mysql database
  Future<int?> insertUser(Map user) async {
    try {
      final command = await _insertCommand('users', true, user);
      final result = await _database.execute(command);

      if (result.isNotEmpty) {
        userCount = result.lastInsertID.toInt();
        return userCount;
      }
    } catch (e) {
      print("Error mysql insert user: ${e.toString()}");
    }
    return null;
  }

  // Update user in mysql database
  Future<bool> updateUser(int id, Map update) async {
    try {
      if (_validUserId(id)) {
        const validKeys = ["mail", "phone", "address", "city"];
        final command = "${_updateCommand('users', validKeys, update)} WHERE id = $id";
        final result = await _database.execute(command);

        if (!result.affectedRows.isNegative) return true;
      }
    } catch (e) {
      print("Error mysql update user: ${e.toString()}");
    }
    return false;
  }

  // Get mysql column names of table
  Future<List<String>> _getColumnNames(String table, bool noPrimaryKey) async {
    try {
      final command = "SHOW COLUMNS FROM $table";
      final result = await _database.execute(command);

      if (result.rows.isNotEmpty) {
        List<String> values = [];

        for (var row in result.rows) {
          final column = row.assoc();
          if (!noPrimaryKey || column["Field"] != 'PRI') {
            final fieldName = column["Field"];
            if (fieldName != null) values.add(fieldName);
          }
        }

        return values;
      } else {
        throw Exception("No column names found in table $table");
      }
    } catch (e) {
      throw Exception("Error get column names of table $table: ${e.toString()}");
    }
  }

  // Check if id exists in jobs database
  bool _validJobId(int id) {
    if (id > jobCount) return false;
    return true;
  }

  // Check if id exists in users database
  bool _validUserId(int id) {
    if (id > userCount) return false;
    return true;
  }

  // Generate MySQL Update command
  String _updateCommand(String table, List<String> keys, Map update) {
    var command = "Update $table SET";

    for (var key in update.keys) {
      if (!keys.contains(key)) {
        throw Exception('Invalid update key: $key');
      }
      command += " $key = ${update[key]},";
    }

    return command.substring(0, command.length - 1);
  }

  // Generate MySQL conditions for command
  String _generateConditions(List<String> keys, Map values) {
    var command = " WHERE";

    for (var key in values.keys) {
      if (!keys.contains(key)) {
        throw Exception('Invalid filter key: $key');
      }
      command += " $key = ${values[key]} AND";
    }

    return command.substring(0, command.length - 4);
  }

  // Generate MySQL insert command (map keys and table keys have to be equal)
  Future<String> _insertCommand(String table, bool noPrimaryKey, Map values) async {
    final keys = await _getColumnNames(table, noPrimaryKey);
    var insertKeys = 'INSERT INTO $table (';
    var insertValues = 'VALUES (';

    for (var key in keys) {
      if (!values.containsKey(key)) {
        throw Exception('Missing table key: $key');
      }

      final value = values[key];
      insertKeys += '$key, ';

      if (value == null) {
        insertValues += 'NULL, ';
      } else if (value.runtimeType == String) {
        insertValues += '"$value", ';
      } else if (value.runtimeType == bool) {
        if (value) {
          insertValues += 'TRUE, ';
        } else {
          insertValues += 'FALSE, ';
        }
      } else {
        insertValues += '$value, ';
      }
    }

    return """${insertKeys.substring(0, insertKeys.length - 2)})
${insertValues.substring(0, insertValues.length - 2)})""";
  }
}
