import 'worker.dart';
import 'kunde.dart';

class User {
  String userID;
  Kunde? kundeID;
  Worker? workerID;
  String nachname;
  String vorname;
  String eMailAdresse;
  String? telefonnummer;

  User({
    required this.userID,
    this.kundeID,
    this.workerID,
    required this.vorname,
    required this.nachname,
    required this.eMailAdresse,
    this.telefonnummer,
  });
}
