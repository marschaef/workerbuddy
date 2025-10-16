import 'package:flutter/material.dart';
import 'package:worker_buddy/utils/app_styles.dart';

class EmptyPage extends StatefulWidget {
  const EmptyPage({super.key});

  @override
  State<EmptyPage> createState() =>
      _EmptyPageState();
}

// Vorlage für die Erstellung neuer Inhalte
class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Title(
        title: 'Empty | WorkerBuddy',
        color: Colors.black,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration:
              AppTheme.getBackgroundGradient(
                Theme.of(context).colorScheme,
              ),
          child: SingleChildScrollView(
            child: Center(),
          ),
        ),
      ),
    );
  }
}
