import 'package:flutter/material.dart';
import 'package:worker_buddy/utils/app_styles.dart';

class ProfilMain extends StatefulWidget {
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const ProfilMain({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<ProfilMain> createState() =>
      _ProfilMainState();
}

class _ProfilMainState extends State<ProfilMain> {
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
            child: Center(child: Text('Profil')),
          ),
        ),
      ),
    );
  }
}
