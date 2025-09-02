import 'package:flutter/material.dart';
import 'package:worker_buddy/app_style.dart';
// import 'package:worker_buddy/passwort_util.dart';
// import 'package:mysql1/mysql1.dart';
// import 'package:worker_buddy/db_connect.dart';

class LoginPage extends StatefulWidget {
  // Variablen und Methoden zur Verwaltung des Inhalts und Titels der Seite
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const LoginPage({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller um den Inhalt von TextFormFields auslesen zu können
  final TextEditingController _eMailAdressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Dispose Methode für TextEditingController
  @override
  void dispose() {
    _eMailAdressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Index für die Verwaltung von Inhalt von Seiten (MainScreen body)
  int localIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      localIndex = index;
    });
    // Callback an Parent aufrufen
    widget.onIndexChanged(index);
  }

  String localTitle = '';

  void _changeTitle(String title) {
    setState(() {
      localTitle = title;
    });
  }

  // Vorerst auskommentiert, bis ich gelernt habe wie man Verbindungen zu
  // Datenbanken herstellt und auf diese zugreift
  Future<bool> verifyLogin(String eMailAdresse, String passwort) async {
    /*
    var results = await conn.query(
      'SELECT user_passwort FROM user WHERE user_email_adresse = ?',
      [eMailAdresse],
    );
    if (results.isNotEmpty) {
      var row = results.first;
      String storedHash = row[0]; //alternativ row['user_passwort']
      return encryptPassword(passwort) == storedHash;
    } else {
      return false;
    }
    */
    return false;
  }

  // Wurde für den Vergleich der gewünschten Button Farbe zur gewählten Button Farbe genutzt.
  // Alternative: Colors.lightBlue[300] / Colors.lightBlue.shade300
  // Siehe Button 'Einloggen'
  Color meineFarbe = Color(0xFF45BDF9);

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Login | WorkerBuddy',
      color: Colors.blue,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppStyle.backgroundGradient,
        // Form zur Verifizierung der TextFormField Inhalte
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Willkommens Text
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Willkommen bei WorkerBuddy!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                // TextFormField für E-Mail Adresse
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: _eMailAdressController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-Mail Adresse',
                      ),
                      // Validator überprüft ob das TextFormField leer ist.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte E-Mail Adresse eingeben';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // TextFormField für Passwort
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Passwort',
                      ),
                      // Validator überprüft ob das TextFormField leer ist.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte Passwort eingeben';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // Button 'Einloggen'
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Methode gibt bool zurück. Login bei true.
                        verifyLogin(
                          _eMailAdressController.toString(),
                          _passwordController.toString(),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      // Hier wird die gewünschte Farbe für den Login Button genutzt
                      backgroundColor: meineFarbe,
                    ),
                    child: Text('Einloggen', style: AppStyle.baseTextStyle),
                  ),
                ),
                // Registrierungs Text
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Noch nicht dabei?',
                    style: AppStyle.baseTextStyle,
                  ),
                ),
                // Butten 'Registrieren'
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _changeIndex(10);
                      _changeTitle('Registrierung | WorkerBuddy');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[300],
                    ),
                    child: Text(
                      'Jetzt Registrieren!',
                      style: AppStyle.baseTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
