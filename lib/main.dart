import 'package:flutter/material.dart';
import 'package:worker_buddy/main_screen.dart';
import 'package:worker_buddy/sites/auftrag_test/auftrag.dart';

void main() {
  runApp(const WorkerBuddyApp());
}

class WorkerBuddyApp extends StatelessWidget {
  const WorkerBuddyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkerBuddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue.shade300,
        ),
      ),
      home: Auftrag(),
    );
  }
}
