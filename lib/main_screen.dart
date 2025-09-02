import 'package:flutter/material.dart';
import 'package:worker_buddy/main_navigation_bar.dart';
import 'package:worker_buddy/sites/landing_page/safe_landing_page.dart';
import 'package:worker_buddy/sites/login/safe_login_page.dart';
import 'package:worker_buddy/sites/auftraege/safe_auftraege_main.dart';
import 'package:worker_buddy/sites/profil/safe_profil_main.dart';
import 'package:worker_buddy/sites/registration/safe_registration_page.dart';
import 'package:worker_buddy/sites/termine/safe_termine_main.dart';
import 'package:worker_buddy/sites/nachrichten/safe_nachrichten_main.dart';
import 'package:worker_buddy/sites/worker/safe_worker_main.dart';
import 'package:worker_buddy/sites/kunden/safe_kunden_main.dart';
import 'package:worker_buddy/sites/kontakte/safe_kontakte_main.dart';
import 'package:worker_buddy/sites/abrechnungen/safe_abrechnung_main.dart';

// MainScreen managed die Darstellung.
//Hier wird die MainNavigationBar geladen und der Kontent der geladenen Seite über den Body gemanaged.

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Index bestimmt den Inhalt des Bodies
  int currentIndex = 0;
  // currentTitle managed den Titel, der im Browser Tab angezeigt wird.
  // Funktioniert aktuell noch nicht (wie gewünscht)
  String currentTitle = "WorkerBuddy";

  // Index Setter
  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  // Title Setter
  void setCurrentTitle(String title) {
    setState(() {
      currentTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: currentTitle,
      color: Colors.blue,
      // Die Tatsächliche Hauptanzeige / Scaffold, in der NavBar und Seiten geladen werden.
      child: Scaffold(
        // Navigation
        appBar: MainNavigationBar(
          currentIndex: currentIndex,
          onIndexChanged: setCurrentIndex,
          currentTitle: currentTitle,
          onTitleChanged: setCurrentTitle,
        ),
        // Inhalt der geladenen Seiten
        body: IndexedStack(
          index: currentIndex,
          children: [
            LandingPage(
              onIndexChanged: setCurrentIndex,
              onTitleChanged: setCurrentTitle,
            ),
            AuftraegeMain(
              onIndexChanged: setCurrentIndex,
              onTitleChanged: setCurrentTitle,
            ),
            ProfilMain(
              onIndexChanged: setCurrentIndex,
              onTitleChanged: setCurrentTitle,
            ),
            TermineMain(
              onIndexChanged: setCurrentIndex,
              onTitleChanged: setCurrentTitle,
            ),
            NachrichtenMain(
              onIndexChanged: setCurrentIndex,
              onTitleChanged: setCurrentTitle,
            ),
            KontakteMain(
              onIndexChanged: setCurrentIndex,
              onTitleChanged: setCurrentTitle,
            ),
            AbrechnungMain(
              onIndexChanged: setCurrentIndex,
              onTitleChanged: setCurrentTitle,
            ),
            WorkerMain(
              onIndexChanged: setCurrentIndex,
              onTitleChanged: setCurrentTitle,
            ),
            KundenMain(
              onIndexChanged: setCurrentIndex,
              onTitleChanged: setCurrentTitle,
            ),
            LoginPage(
              onIndexChanged: setCurrentIndex,
              onTitleChanged: setCurrentTitle,
            ),
            RegistrationPage(
              onIndexChanged: setCurrentIndex,
              onTitleChanged: setCurrentTitle,
            ),
          ],
        ),
      ),
    );
  }
}
