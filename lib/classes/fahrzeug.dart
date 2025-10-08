import 'worker.dart';
import 'unternehmen.dart';

class Fahrzeug {
  int fahrzeugID;
  Worker? worker;
  Unternehmen? unternehmen;
  String modell;
  String kennzeichen;
  String? details;

  Fahrzeug({
    required this.fahrzeugID,
    this.worker,
    this.unternehmen,
    required this.modell,
    required this.kennzeichen,
    this.details,
  });
}
