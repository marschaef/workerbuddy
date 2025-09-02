import 'package:flutter/material.dart';
import 'package:worker_buddy/app_style.dart';

class AbrechnungMain extends StatefulWidget {
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;
  const AbrechnungMain({
    super.key,
    required this.onIndexChanged,
    required this.onTitleChanged,
  });

  @override
  State<AbrechnungMain> createState() => _AbrechnungMainState();
}

class _AbrechnungMainState extends State<AbrechnungMain> {
  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Abrechnung | WorkerBuddy',
      color: Colors.black,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppStyle.backgroundGradient,
        child: Center(child: Text('Abrechnung')),
      ),
    );
  }
}
