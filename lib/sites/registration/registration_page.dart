import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worker_buddy/app_style.dart';

class RegistrationPage extends StatefulWidget {
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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _eMailAdressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Registrierung | WorkerBuddy',
      color: Colors.black,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppStyle.backgroundGradient,
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: _phoneNumberController,
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
                        if (value != _passwordController.text) {
                          return 'Die Passwörter stimmen nicht überein';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Formular ist gültig
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Passwörter stimmen überein')),
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

          /*
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Registriere dich hier',
                  style: AppStyle.baseTextStyle,
                ),
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Vorname ', style: AppStyle.baseTextStyle),
                      Text('Nachname ', style: AppStyle.baseTextStyle),
                      Text('Telefonnummer ', style: AppStyle.baseTextStyle),
                      Text('E-Mail Adresse  ', style: AppStyle.baseTextStyle),
                      Text('Passwort ', style: AppStyle.baseTextStyle),
                      Text(
                        'Passwort wiederholen ',
                        style: AppStyle.baseTextStyle,
                      ),
                    ],
                  ),
                  Column(children: []),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Nachname ', style: AppStyle.baseTextStyle),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Passwort',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[300],
                  ),
                  child: Text('Einloggen', style: AppStyle.baseTextStyle),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text('Noch nicht dabei?', style: AppStyle.baseTextStyle),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {},
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
    );
  }
}
*/