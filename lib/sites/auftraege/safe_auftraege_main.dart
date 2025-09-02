import 'package:flutter/material.dart';
import 'package:worker_buddy/app_style.dart';

class AuftraegeMain extends StatefulWidget {
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const AuftraegeMain({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<AuftraegeMain> createState() => _AuftraegeMainState();
}

class _AuftraegeMainState extends State<AuftraegeMain> {
  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Home | WorkerBuddy',
      color: Colors.black,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppStyle.backgroundGradient,
        child: Center(child: Text('Aufträge')),
      ),
    );
  }
}
