import 'package:flutter/material.dart';
import 'package:worker_buddy/main_navigation_bar.dart';
import 'package:worker_buddy/sites/landing_page/landing_page.dart';
import 'package:worker_buddy/sites/login/login_page.dart';
import 'package:worker_buddy/sites/auftraege/auftraege_main.dart';
import 'package:worker_buddy/sites/profil/profil_main.dart';
import 'package:worker_buddy/sites/registration/registration_page.dart';
import 'package:worker_buddy/sites/termine/termine_main.dart';
import 'package:worker_buddy/sites/nachrichten/nachrichten_main.dart';
import 'package:worker_buddy/sites/worker/worker_main.dart';
import 'package:worker_buddy/sites/kunden/kunden_main.dart';
import 'package:worker_buddy/sites/kontakte/kontakte_main.dart';
import 'package:worker_buddy/sites/abrechnungen/abrechnung_main.dart';

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
