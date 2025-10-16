import 'package:flutter/material.dart';
import 'package:worker_buddy/utils/app_styles.dart';

class AuftraegeMain extends StatefulWidget {
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const AuftraegeMain({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<AuftraegeMain> createState() =>
      _AuftraegeMainState();
}

class _AuftraegeMainState
    extends State<AuftraegeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Title(
        title: 'Home | WorkerBuddy',
        color: Colors.black,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration:
              AppTheme.getBackgroundGradient(
                Theme.of(context).colorScheme,
              ),
          child: SingleChildScrollView(
            child: Center(
              child: Text('Aufträge'),
            ),
          ),
        ),
      ),
    );
  }
}
