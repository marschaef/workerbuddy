class Adresse {
  int adresseID;
  String strasse;
  String hausnummer;
  String? adresszusatz;
  String plz;
  String ort;
  String land;

  Adresse({
    required this.adresseID,
    required this.strasse,
    required this.hausnummer,
    this.adresszusatz,
    required this.plz,
    required this.ort,
    required this.land,
  });
}
