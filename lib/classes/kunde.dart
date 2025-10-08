import 'adresse.dart';
import 'zahlungsinformation.dart';

class Kunde {
  int kundeID;
  String vorname;
  String nachname;
  String emailAdresse;
  Adresse? adresse;
  String? telefonnummer;
  String? mobilfunknummer;
  String? fax;
  String? gruppe;
  String? sprache;
  DateTime? geburtsdatum;
  String? kundenNotiz;
  String? adminNotiz;
  String? akquiseWeg;
  DateTime? meldeDatum;
  bool erlaubePostPaid;
  bool erlaubeFreitextNachrichten;
  Zahlungsinformation? zahlungsinformation;

  Kunde({
    required this.kundeID,
    required this.vorname,
    required this.nachname,
    required this.emailAdresse,
    this.adresse,
    this.telefonnummer,
    this.mobilfunknummer,
    this.fax,
    this.gruppe,
    this.sprache,
    this.geburtsdatum,
    this.kundenNotiz,
    this.adminNotiz,
    this.akquiseWeg,
    this.meldeDatum,
    required this.erlaubePostPaid,
    required this.erlaubeFreitextNachrichten,
    this.zahlungsinformation,
  });
}
