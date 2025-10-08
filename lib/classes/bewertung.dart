import 'kunde.dart';
import 'unternehmen.dart';
import 'worker.dart';

class Bewertung {
  int bewertungID;
  Kunde? kundeBewertet;
  Unternehmen? unternehmenBewertet;
  Worker? workerBewertet;
  Kunde? bewertungVonKunde;
  Unternehmen? bewertungVonUnternehmen;
  Worker? bewertungVonWorker;
  int anzahlSterne;
  String? bewertungText;

  Bewertung({
    required this.bewertungID,
    this.kundeBewertet,
    this.unternehmenBewertet,
    this.workerBewertet,
    this.bewertungVonKunde,
    this.bewertungVonUnternehmen,
    this.bewertungVonWorker,
    required this.anzahlSterne,
    this.bewertungText,
  });
}
