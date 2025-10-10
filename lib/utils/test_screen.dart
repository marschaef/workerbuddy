import 'package:worker_buddy/utils/app_styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const StyleTestApp());
}

class StyleTestApp extends StatelessWidget {
  const StyleTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Entfernt das "Debug"-Banner oben rechts
      debugShowCheckedModeBanner: false,
      home: StyleTestPage(),
    );
  }
}

// Die eigentliche Seite, die alle deine Styles anzeigt
class StyleTestPage extends StatelessWidget {
  const StyleTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: const Text('Design System Test'),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: ListView( // ListView, damit du scrollen kannst, falls es viele Elemente werden
        padding: const EdgeInsets.all(AppStyles.paddingMedium),
        children: [
          // -- Farbschema --
          const Text('Farben', style: AppStyles.headLine1),
          const SizedBox(height: AppStyles.paddingSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColorCircle(AppStyles.primaryColor, 'Primary'),
              _buildColorCircle(AppStyles.accentColor, 'Accent'),
              _buildColorCircle(AppStyles.textColor, 'Text'),
            ],
          ),
          const SizedBox(height: AppStyles.paddingLarge),

          // -- Text-Stile --
          const Text('Text-Stile', style: AppStyles.headLine1),
          const SizedBox(height: AppStyles.paddingSmall),
          const Text('Das ist ein Headline 1', style: AppStyles.headLine1),
          const SizedBox(height: AppStyles.paddingSmall),
          const Text('Das ist ein normaler Body-Text. Lorem ipsum dolor sit amet, consectetur adipiscing elit.', style: AppStyles.bodyText),
          const SizedBox(height: AppStyles.paddingLarge),
          
          // -- Buttons und Container --
          const Text('Buttons & Container', style: AppStyles.headLine1),
          const SizedBox(height: AppStyles.paddingSmall),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppStyles.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyles.borderRadius),
              ),
            ),
            onPressed: () {},
            child: const Text('Styled Button', style: AppStyles.buttonText),
          ),
          const SizedBox(height: AppStyles.paddingMedium),
          Container(
            padding: const EdgeInsets.all(AppStyles.paddingMedium),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppStyles.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                )
              ]
            ),
            child: const Text('Ein Container mit BorderRadius und Schatten.', style: AppStyles.bodyText),
          ),
        ],
      ),
    );
  }

  // Hilfs-Widget, um einen Farbkreis darzustellen
  Widget _buildColorCircle(Color color, String name) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black26),
          ),
        ),
        const SizedBox(height: 4),
        Text(name),
      ],
    );
  }
}