import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worker_buddy/app_style.dart';
// import 'package:worker_buddy/passwort_util.dart';
// import 'package:mysql1/mysql1.dart';
// import 'package:worker_buddy/db_connect.dart';

class RegistrationPage extends StatefulWidget {
  // Variablen und Methoden zur Verwaltung des Inhalts und Titels der Seite
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const RegistrationPage({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller um den Inhalt von TextFormFields auslesen zu können
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _eMailAdressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  // Dispose Methode für TextEditingController
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _eMailAdressController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // Methode zum Eintrag von Registrierungsdaten in die Datenbank
  /*
  Future<void> registerUser(
    String vorname,
    String nachname,
    String telefonnummer,
    String eMailAdresse,
    String passwort,
  ) async {
    var result = await DbConnect.conn.query(
      'INSERT INTO user (user_vorname, user_nachname, user_telefonnummer, user_email_adresse, user_passwort) VALUES (?, ?, ?, ?, ?)',
      [
        vorname,
        nachname,
        telefonnummer,
        eMailAdresse,
        encryptPassword(passwort),
      ],
    );
    //return result;
  }
  */

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Registrierung | WorkerBuddy',
      color: Colors.black,
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
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Text(
                    'Willkommen bei WorkerBuddy!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                // Aufforderung der Eingabe der notwendigen Daten
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Bitte geben Sie Ihre Daten ein.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                // TextFormField für Vorname
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: _firstNameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Vorname*',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte Vornamen eingeben';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // TextFormField für Nachname
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: _lastNameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nachname*',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte Nachnamen eingeben';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // TextFormField für (bisher optionale) Telefonnummer
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: _phoneNumberController,
                      // Limitierung auf für Telefonnummern benötigte Zeichen
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9+]+')),
                      ],
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Telefonnummer',
                      ),
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
                        labelText: 'E-Mail Adresse*',
                      ),
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
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Passwort*',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte Passwort eingeben';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // TextFormField für Wiederholung des Passworts
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: _confirmController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Passwort wiederholen*',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte Passwort wiederholen';
                        }
                        // Überprüfung der Übereinstimmung der Passwörter
                        if (value != _passwordController.text) {
                          return 'Die Passwörter stimmen nicht überein';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // Hinweis auf Pflichteingaben
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                  child: Text(
                    '*Pflichtangaben',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                // Button zur Registrierung
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Formular ist gültig
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Inhalt vollständig')),
                          // registerUser(_firstNameController.toString(), _lastNameController.toString(), _phoneNumberController.toString(), _eMailAdressController.toString(), _passwordController.toString());
                        );
                      }
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
