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

import 'package:worker_buddy/navigation_items.dart';

// MainScreen managed die Darstellung und den Body-Inhalt.

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() =>
      _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Bestimmt den aktuellen Body-Inhalt.
  int currentIndex = 0;
  // Titel für den Browser-Tab.
  String currentTitle = "WorkerBuddy";

  // Setter für den Index.
  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  // Setter für den Titel.
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
      // Haupt-Scaffold mit NavBar und Seiten-Inhalt.
      child: Scaffold(
        // Hauptnavigation.
        appBar: MainNavigationBar(
          currentIndex: currentIndex,
          onIndexChanged: setCurrentIndex,
          currentTitle: currentTitle,
          onTitleChanged: setCurrentTitle,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[300],
                ),
                child: const Text(
                  'Navigation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ...navigationItems.map((item) {
                return ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.title),
                  onTap: () {
                    setCurrentIndex(item.index);
                    setCurrentTitle(
                      '${item.title} | WorkerBuddy',
                    );
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        ),
        // Body-Inhalt.
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
