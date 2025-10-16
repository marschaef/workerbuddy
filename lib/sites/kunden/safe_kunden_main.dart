import 'package:flutter/material.dart';
import 'package:worker_buddy/utils/app_styles.dart';

class KundenMain extends StatefulWidget {
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const KundenMain({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<KundenMain> createState() =>
      _KundenMainState();
}

class _KundenMainState extends State<KundenMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Title(
        title: 'Kunden | WorkerBuddy',
        color: Colors.black,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration:
              AppTheme.getBackgroundGradient(
                Theme.of(context).colorScheme,
              ),
          child: SingleChildScrollView(
            child: Center(child: Text('Kunden')),
          ),
        ),
      ),
    );
  }
}
