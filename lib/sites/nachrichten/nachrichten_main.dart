import 'package:flutter/material.dart';
import 'package:worker_buddy/app_style.dart';

class NachrichtenMain extends StatefulWidget {
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const NachrichtenMain({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<NachrichtenMain> createState() => _NachrichtenMainState();
}

class _NachrichtenMainState extends State<NachrichtenMain> {
  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Home | WorkerBuddy',
      color: Colors.black,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppStyle.backgroundGradient,
        child: Center(child: Text('Nachrichten')),
      ),
    );
  }
}
