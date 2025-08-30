import 'package:flutter/material.dart';
// import 'package:worker_buddy/app_style.dart';
import 'package:worker_buddy/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkerBuddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue.shade300),
      ),
      home: MainScreen(),
    );
  }
}
