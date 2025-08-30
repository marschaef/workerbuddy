import 'package:flutter/material.dart';
import 'package:worker_buddy/app_style.dart';

class WorkerMain extends StatefulWidget {
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const WorkerMain({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<WorkerMain> createState() => _WorkerMainState();
}

class _WorkerMainState extends State<WorkerMain> {
  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Worker | WorkerBuddy',
      color: Colors.black,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppStyle.backgroundGradient,
        child: Center(child: Text('Worker')),
      ),
    );
  }
}
