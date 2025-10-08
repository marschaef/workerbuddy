import 'kunde.dart';
import 'unternehmen.dart';
import 'worker.dart';
import 'auftrag.dart';

class Nachricht {
  int nachrichtID;
  Kunde? kundePrivat;
  Worker? worker;
  Auftrag auftrag;
  String nachrichtInhalt;
  DateTime erstellungNachricht;
  Unternehmen? kundeGewerblich;
  Unternehmen? unternehmen;

  Nachricht({
    required this.nachrichtID,
    this.kundePrivat,
    this.worker,
    required this.auftrag,
    required this.nachrichtInhalt,
    required this.erstellungNachricht,
    this.kundeGewerblich,
    this.unternehmen,
  });
}
