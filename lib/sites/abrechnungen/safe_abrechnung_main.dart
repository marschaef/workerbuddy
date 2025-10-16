import 'package:flutter/material.dart';
import 'package:worker_buddy/utils/app_styles.dart';

class AbrechnungMain extends StatefulWidget {
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const AbrechnungMain({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<AbrechnungMain> createState() =>
      _AbrechnungMainState();
}

class _AbrechnungMainState
    extends State<AbrechnungMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Title(
        title: 'Abrechnung | WorkerBuddy',
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
              child: Text('Abrechnung'),
            ),
          ),
        ),
      ),
    );
  }
}
