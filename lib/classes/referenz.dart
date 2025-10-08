import 'worker.dart';
import 'unternehmen.dart';

class Referenz {
  int referenzID;
  Worker? worker;
  Unternehmen? unternehmen;
  String beschreibung;
  String? details;

  Referenz({
    required this.referenzID,
    this.worker,
    this.unternehmen,
    required this.beschreibung,
    this.details,
  });
}
