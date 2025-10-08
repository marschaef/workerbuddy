import 'worker.dart';
import 'unternehmen.dart';

class Werkzeug {
  int werkzeugID;
  Worker? worker;
  Unternehmen? unternehmen;
  String beschreibung;
  String? details;

  Werkzeug({
    required this.werkzeugID,
    this.worker,
    this.unternehmen,
    required this.beschreibung,
    this.details,
  });
}
