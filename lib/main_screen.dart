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

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  String currentTitle = "WorkerBuddy";

  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

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
      child: Scaffold(
        appBar: MainNavigationBar(
          currentIndex: currentIndex,
          onIndexChanged: setCurrentIndex,
          currentTitle: currentTitle,
          onTitleChanged: setCurrentTitle,
        ),
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
