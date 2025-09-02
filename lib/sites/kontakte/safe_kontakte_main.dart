import 'package:flutter/material.dart';
import 'package:worker_buddy/app_style.dart';

class KontakteMain extends StatefulWidget {
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const KontakteMain({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<KontakteMain> createState() => _KontakteMainState();
}

class _KontakteMainState extends State<KontakteMain> {
  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Home | WorkerBuddy',
      color: Colors.black,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppStyle.backgroundGradient,
        child: Center(child: Text('Kontakte')),
      ),
    );
  }
}
