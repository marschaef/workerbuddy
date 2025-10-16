import 'package:flutter/material.dart';
import 'package:worker_buddy/main_screen.dart';
import 'package:worker_buddy/utils/app_styles.dart';

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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: MainScreen(),
    );
  }
}
