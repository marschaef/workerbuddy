import 'package:flutter/material.dart';
import 'package:worker_buddy/app_style.dart';

class MainNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(90);

  final int currentIndex;
  final String currentTitle;
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;

  const MainNavigationBar({
    required this.currentIndex,
    required this.onIndexChanged,
    required this.currentTitle,
    required this.onTitleChanged,
  });
  // const MainNavigationBar({super.key})

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: InkWell(
        onTap: () {
          onIndexChanged(0);
          onTitleChanged('Home | WorkerBuddy');
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 20, 10, 10),
          child: Image.asset(
            '/images/wb_logo_komplett.jpg',
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 30, 10),
          child: IconButton(
            // Falls Login Text hinzugefügt werden soll elevatedButton nutzen und label: Text('') ergänzen.
            icon: Icon(Icons.login),
            tooltip: 'Login',
            onPressed: () {
              // Weiterleitung zu LoginPage
              onIndexChanged(9);
              onTitleChanged('Login | WorkerBuddy');
            },
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(35.0), // Höhe des unteren Bereichs
        // bottom Container für Navigation Buttons
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue[300],
            border: Border.all(color: Colors.black, width: 2.0),
          ),
          height: 30.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  // Aktion für Button Aufträge
                  onIndexChanged(1);
                  onTitleChanged('Aufträge | WorkerBuddy');
                },
                child: Text(
                  'Aufträge',
                  style: currentIndex == 1
                      ? AppStyle.pressedTextStyle
                      : AppStyle.baseTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Aktion für Button Profil
                  onIndexChanged(2);
                  onTitleChanged('Profil | WorkerBuddy');
                },
                child: Text(
                  'Profil',
                  style: currentIndex == 2
                      ? AppStyle.pressedTextStyle
                      : AppStyle.baseTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Aktion für Button Termine
                  onIndexChanged(3);
                  onTitleChanged('Termine | WorkerBuddy');
                },
                child: Text(
                  'Termine',
                  style: currentIndex == 3
                      ? AppStyle.pressedTextStyle
                      : AppStyle.baseTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Aktion für Button Nachrichten
                  onIndexChanged(4);
                  onTitleChanged('Nachrichten | WorkerBuddy');
                },
                child: Text(
                  'Nachrichten',
                  style: currentIndex == 4
                      ? AppStyle.pressedTextStyle
                      : AppStyle.baseTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Aktion für Button Kontakte
                  onIndexChanged(5);
                  onTitleChanged('Kontakte | WorkerBuddy');
                },
                child: Text(
                  'Kontakte',
                  style: currentIndex == 5
                      ? AppStyle.pressedTextStyle
                      : AppStyle.baseTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Aktion für Button Abrechnung
                  onIndexChanged(6);
                  onTitleChanged('Abrechnung | WorkerBuddy');
                },
                child: Text(
                  'Abrechnung',
                  style: currentIndex == 6
                      ? AppStyle.pressedTextStyle
                      : AppStyle.baseTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Aktion für Button Worker
                  onIndexChanged(7);
                  onTitleChanged('Worker | WorkerBuddy');
                },
                child: Text(
                  'Worker',
                  style: currentIndex == 7
                      ? AppStyle.pressedTextStyle
                      : AppStyle.baseTextStyle,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Aktion für Button Kunden
                  onIndexChanged(8);
                  onTitleChanged('Kunden | WorkerBuddy');
                },
                child: Text(
                  'Kunden',
                  style: currentIndex == 8
                      ? AppStyle.pressedTextStyle
                      : AppStyle.baseTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
      shape: Border(
        top: BorderSide(color: Colors.lightBlue.shade300, width: 3),
        left: BorderSide(color: Colors.lightBlue.shade300, width: 3),
        right: BorderSide(color: Colors.lightBlue.shade300, width: 3),
      ),
    );
  }
}
