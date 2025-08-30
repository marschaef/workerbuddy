import 'package:flutter/material.dart';
import 'package:worker_buddy/app_style.dart';

class LoginPage extends StatefulWidget {
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
  final TextEditingController _eMailAdressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _eMailAdressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  int localIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      localIndex = index;
    });
    widget.onIndexChanged(index); // Callback an Parent aufrufen
  }

  String localTitle = '';
  void _changeTitle(String title) {
    setState(() {
      localTitle = title;
    });
  }

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
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Wilkommen bei WorkerBuddy!',
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
                      controller: _eMailAdressController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-Mail Adresse',
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
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Formular ist gültig
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Ungültig')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: meineFarbe,
                    ),
                    child: Text('Einloggen', style: AppStyle.baseTextStyle),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Noch nicht dabei?',
                    style: AppStyle.baseTextStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _changeIndex(10);
                      _changeTitle('Kontakte | WorkerBuddy');
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
