import 'auftrag.dart';
import 'paket.dart';

class Material {
  int materialID;
  String materialBeschreibung;
  double materialMenge;
  double materialPreis;
  bool? istZugebucht;
  Auftrag? auftrag;
  Paket? paket;
  String? materialKommentar;

  Material({
    required this.materialID,
    required this.materialBeschreibung,
    required this.materialMenge,
    required this.materialPreis,
    this.istZugebucht,
    this.auftrag,
    this.paket,
    this.materialKommentar,
  });
}
