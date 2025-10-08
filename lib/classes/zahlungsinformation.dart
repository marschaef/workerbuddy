import 'adresse.dart';

class Zahlungsinformation {
  int zahlungsinformationID;
  String? iban;
  String? bic;
  String? bank;
  String? kreditkartennummer;
  DateTime? ablaufdatum;
  String? cvc;
  String? paypalAdresse;
  Adresse? rechnungsadresse;

  Zahlungsinformation({
    required this.zahlungsinformationID,
    this.iban,
    this.bic,
    this.bank,
    this.kreditkartennummer,
    this.ablaufdatum,
    this.cvc,
    this.paypalAdresse,
    this.rechnungsadresse,
  });
}
