import 'adresse.dart';
import 'worker.dart';
import 'zahlungsinformation.dart';

class Unternehmen {
  int unternehmenID;
  String firma;
  Worker inhaber;
  String steuerID;
  String umsatzsteuerID;
  Zahlungsinformation? zahlungsinformation;
  String? telefonnummer;
  String? mobilfunknummer;
  String? emailAdresse;
  String? fax;
  String? postfach;
  Adresse adresse;

  Unternehmen({
    required this.unternehmenID,
    required this.firma,
    required this.inhaber,
    required this.steuerID,
    required this.umsatzsteuerID,
    this.zahlungsinformation,
    this.telefonnummer,
    this.mobilfunknummer,
    this.emailAdresse,
    this.fax,
    this.postfach,
    required this.adresse,
  });
}
