import 'package:worker_buddy/classes/zahlungsinformation.dart';

class Worker {
  int workerID;
  String steuerID;
  Zahlungsinformation? zahlungsinformation;

  Worker({
    required this.workerID,
    required this.steuerID,
    this.zahlungsinformation,
  });
}
