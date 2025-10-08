import 'auftrag.dart';

class Termin {
  int terminID;
  Auftrag? auftrag;
  DateTime? terminDurchfuehrung;
  bool? istFolgetermin;
  Termin? vorherigerTermin;
  String? kommentarTerminfindung;
  DateTime? datumRueckruf;
  DateTime? uhrzeitRueckruf;
  String? terminBeschreibung;
  String? terminKommentar;
  DateTime? terminBestaetigt;
  DateTime? terminAbgesagt;
  String? terminAbgesagtBegruendung;
  DateTime? terminVerlegt;
  String? terminVerlegtBegruendung;
  DateTime? terminVereinbart;

  Termin({
    required this.terminID,
    this.auftrag,
    this.terminDurchfuehrung,
    this.istFolgetermin,
    this.vorherigerTermin,
    this.kommentarTerminfindung,
    this.datumRueckruf,
    this.uhrzeitRueckruf,
    this.terminBeschreibung,
    this.terminKommentar,
    this.terminBestaetigt,
    this.terminAbgesagt,
    this.terminAbgesagtBegruendung,
    this.terminVerlegt,
    this.terminVerlegtBegruendung,
    this.terminVereinbart,
  });
}
