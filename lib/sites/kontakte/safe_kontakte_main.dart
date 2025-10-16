import 'package:flutter/material.dart';
import 'package:worker_buddy/utils/app_styles.dart';

class KontakteMain extends StatefulWidget {
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const KontakteMain({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<KontakteMain> createState() =>
      _KontakteMainState();
}

class _KontakteMainState
    extends State<KontakteMain> {
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
              child: Text('Kontakte'),
            ),
          ),
        ),
      ),
    );
  }
}
