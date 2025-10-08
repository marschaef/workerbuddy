import 'paket.dart';
import 'kunde.dart';
import 'unternehmen.dart';
import 'adresse.dart';

class Auftrag {
  int auftragID;
  Paket paket;
  Adresse auftragsort;
  DateTime auftragErstellt;
  DateTime? auftragAngenommen;
  Unternehmen? durchfuehrendesUnternehmen;
  bool istPrivat;
  bool istGewerblich;
  Kunde? auftraggeberPrivat;
  Unternehmen? auftraggeberGewerblich;
  Kunde? kundePrivat;
  Unternehmen? kundeGewerblich;
  bool auftragBilderHochgeladen;
  bool auftragDateienHochgeladen;
  String auftragBeschreibung;
  String auftragOertlicheGegebenheiten;
  DateTime auftragDatumVon;
  DateTime auftragDatumBis;
  DateTime auftragUhrzeitVon;
  DateTime auftragUhrzeitBis;
  String? auftragTerminKommentar;
  bool? auftragIstExpressZweiTage;
  bool? auftragIstExpressEineWoche;
  bool? auftragIstExpressEinMonat;
  bool? auftragIstFesterTermin;
  String? materialPaketdienstleister;
  String? materialSendungsnummer;
  String zahlungArt;
  String? zahlungStatus;
  DateTime? zahlungStatusGeaendert;
  String? rechnungsnummer;
  String? auftragStatus;
  DateTime? auftragStatusGeaendert;
  bool? terminVereinbart;
  DateTime? trackingWorkerUnterwegs;
  DateTime? trackingWorkerAngekommen;
  String? trackingAnfahrtDokumentierung;
  DateTime? trackingArbeitBegonnen;
  String? trackingArbeitBegonnenDokumentierung;
  String? trackingAbweichenderOrtDokumentierung;
  DateTime? trackingArbeitUnterbrochen;
  DateTime? trackingArbeitWeitergefuehrt;
  DateTime? trackingArbeitBeendet;
  DateTime? trackingAuftragAbgeschlossen;
  int? zugebuchhteZeit;
  int? zugebuchteZeitPaket;
  String? zugebuchteZeitKommentar;
  DateTime? zugebuchteZeitbestaetigt;
  DateTime? zugebuchtsMaterialBestartigt;
  bool? dokumentationWorkerBilderHochgeladen;
  bool? dokumentationWorkerDateienHochgeladen;
  String? dokumentationWorkerText;
  bool? dokumentationKundeBilderHochgeladen;
  bool? dokumentationKundeDateienHochgeladen;
  String? dokumentationKundeText;
  bool? istAbgeschlossen;
  bool? istFolgeterminGewuenscht;
  bool? istFolgeterminVereinbart;
  String? keinFolgeterminBegruendung;
  bool? istKundeBewertet;
  bool? istWorkerBewertet;
  bool? istUnternehmenBewertet;

  Auftrag({
    required this.auftragID,
    required this.paket,
    required this.auftragsort,
    required this.auftragErstellt,
    this.auftragAngenommen,
    this.durchfuehrendesUnternehmen,
    required this.istPrivat,
    required this.istGewerblich,
    this.auftraggeberPrivat,
    this.auftraggeberGewerblich,
    this.kundePrivat,
    this.kundeGewerblich,
    required this.auftragBilderHochgeladen,
    required this.auftragDateienHochgeladen,
    required this.auftragBeschreibung,
    required this.auftragOertlicheGegebenheiten,
    required this.auftragDatumVon,
    required this.auftragDatumBis,
    required this.auftragUhrzeitVon,
    required this.auftragUhrzeitBis,
    this.auftragTerminKommentar,
    this.auftragIstExpressZweiTage,
    this.auftragIstExpressEineWoche,
    this.auftragIstExpressEinMonat,
    this.auftragIstFesterTermin,
    this.materialPaketdienstleister,
    this.materialSendungsnummer,
    required this.zahlungArt,
    this.zahlungStatus,
    this.zahlungStatusGeaendert,
    this.rechnungsnummer,
    this.auftragStatus,
    this.auftragStatusGeaendert,
    this.terminVereinbart,
    this.trackingWorkerUnterwegs,
    this.trackingWorkerAngekommen,
    this.trackingAnfahrtDokumentierung,
    this.trackingArbeitBegonnen,
    this.trackingArbeitBegonnenDokumentierung,
    this.trackingAbweichenderOrtDokumentierung,
    this.trackingArbeitUnterbrochen,
    this.trackingArbeitWeitergefuehrt,
    this.trackingArbeitBeendet,
    this.trackingAuftragAbgeschlossen,
    this.zugebuchhteZeit,
    this.zugebuchteZeitPaket,
    this.zugebuchteZeitKommentar,
    this.zugebuchteZeitbestaetigt,
    this.zugebuchtsMaterialBestartigt,
    this.dokumentationWorkerBilderHochgeladen,
    this.dokumentationWorkerDateienHochgeladen,
    this.dokumentationWorkerText,
    this.dokumentationKundeBilderHochgeladen,
    this.dokumentationKundeDateienHochgeladen,
    this.dokumentationKundeText,
    this.istAbgeschlossen,
    this.istFolgeterminGewuenscht,
    this.istFolgeterminVereinbart,
    this.keinFolgeterminBegruendung,
    this.istKundeBewertet,
    this.istWorkerBewertet,
    this.istUnternehmenBewertet,
  });
}
