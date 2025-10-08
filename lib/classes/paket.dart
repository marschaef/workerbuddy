import 'unternehmen.dart';
import 'skill.dart';

class Paket {
  int paketID;
  String paketName;
  int paketPauerInMinuten;
  Skill? benoetigterSkill;
  int? anzahlWorker;
  double paketPreis;
  Unternehmen? paketBesitzer;
  String? paketBeschreibung;
  String? anmerkung;

  Paket({
    required this.paketID,
    required this.paketName,
    required this.paketPauerInMinuten,
    this.benoetigterSkill,
    this.anzahlWorker,
    required this.paketPreis,
    this.paketBesitzer,
    this.paketBeschreibung,
    this.anmerkung,
  });
}
