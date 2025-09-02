import 'package:flutter/material.dart';
import 'package:worker_buddy/app_style.dart';

class TermineMain extends StatefulWidget {
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const TermineMain({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<TermineMain> createState() => _TermineMainState();
}

class _TermineMainState extends State<TermineMain> {
  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Home | WorkerBuddy',
      color: Colors.black,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppStyle.backgroundGradient,
        child: Center(child: Text('Termine')),
      ),
    );
  }
}
