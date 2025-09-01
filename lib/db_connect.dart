import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

// Von AI generierte Datei zur Herstellung von Verbindungen zu einer Datenbank

class DbConnect extends StatefulWidget {
  const DbConnect({super.key});

  @override
  _DbConnectState createState() => _DbConnectState();
}

class _DbConnectState extends State<DbConnect> {
  String status = "Verbinde...";
  late Future<void> dbFuture;

  @override
  void initState() {
    super.initState();
    dbFuture = connectToMySql();
  }

  Future<void> connectToMySql() async {
    try {
      final settings = ConnectionSettings(
        host: 'merkur.2-host.de',
        port: 3306,
        user: '',
        password: '',
        db: 'workerbuddy',
      );

      final conn = await MySqlConnection.connect(settings);
      setState(() {
        status = "Verbindung erfolgreich!";
      });

      /* 
      Beispiel Abfrage von Daten

      var results = await conn.query('SELECT name FROM users LIMIT 5');
      for (var row in results) {
        print('Name: ${row[0]}');
      }

      Beispiel Eintrag von Daten
      
      var result = await conn.query(
      'INSERT INTO user (user_email_adresse, user_passwort) VALUES (?, ?)',
      [user_email_adresse, user_passwort],
      );
      print('Inserted row id=${result.insertId}');
      */

      await conn.close();
    } catch (e) {
      setState(() {
        status = "Fehler: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MySQL Beispiel')),
      body: Center(
        child: FutureBuilder<void>(
          future: dbFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Fehler: ${snapshot.error}');
            }
            return Text(status);
          },
        ),
      ),
    );
  }
}
