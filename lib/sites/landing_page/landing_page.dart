import 'package:flutter/material.dart';
import 'package:worker_buddy/app_style.dart';

class LandingPage extends StatefulWidget {
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const LandingPage({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Home | WorkerBuddy',
      color: Colors.black,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppStyle.backgroundGradient,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                child: Image.asset(
                  '/images/wb_logo_komplett.jpg',
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                'Dein digitaler Freund für jeden Auftrag.\n',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(text: 'Mit '),
                    TextSpan(
                      text: 'WorkerBuddy',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ''' wird Arbeit einfacher:
Aufträge finden, organisieren, abarbeiten, dokumentieren und abrechnen – 
und noch vieles mehr.
Ob als Unternehmen, Privatperson oder Arbeiter: Aufträge können eingestellt, 
angenommen und gemeinsam effizient umgesetzt werden.
Zukünftig erwarten dich viele weitere smarte Tools rund um deine Arbeit.''',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
