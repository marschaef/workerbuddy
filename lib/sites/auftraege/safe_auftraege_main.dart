import 'package:flutter/material.dart';
import 'package:worker_buddy/utils/app_styles.dart';

class Order {
  final String title;
  final String description;
  final String status;

  Order({required this.title, required this.description, required this.status});
}

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
  final List<Order> _placeholderOrders = [
    Order(
      title: 'Möbelmontage',
      description: 'Montage von IKEA PAX Kleiderschrank.',
      status: 'Offen',
    ),
    Order(
      title: 'Gartenarbeit',
      description: 'Rasen mähen und Hecke schneiden.',
      status: 'In Bearbeitung',
    ),
    Order(
      title: 'Wohnungsreinigung',
      description: 'Grundreinigung einer 3-Zimmer-Wohnung.',
      status: 'Abgeschlossen',
    ),
    Order(
      title: 'Umzugshilfe',
      description: 'Transport von Kartons und Möbeln.',
      status: 'Offen',
    ),
    Order(
      title: 'Renovierungsarbeiten',
      description: 'Streichen von Wänden und Decken.',
      status: 'Offen',
    ),
    Order(
      title: 'Heizungsreparatur',
      description: 'Reparatur einer defekten Heizungsanlage.',
      status: 'In Bearbeitung',
    ),
    Order(
      title: 'Elektroinstallation',
      description: 'Installation neuer Steckdosen und Lichtschalter.',
      status: 'Abgeschlossen',
    ),
    Order(
      title: 'Rohrreinigung',
      description: 'Beseitigung einer Verstopfung im Abfluss.',
      status: 'Offen',
    ),
    Order(
      title: 'Fensterreinigung',
      description: 'Reinigung aller Fenster im Haus.',
      status: 'Offen',
    ),
    Order(
      title: 'Dachreparatur',
      description: 'Ausbesserung kleinerer Schäden am Dach.',
      status: 'In Bearbeitung',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Title(
        title: 'Home | WorkerBuddy',
        color: Colors.black,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: AppTheme.getBackgroundGradient(
            Theme.of(context).colorScheme,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _placeholderOrders.length,
                itemBuilder: (context, index) {
                  final order = _placeholderOrders[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(order.description),
                          const SizedBox(height: 8),
                          Text(
                            'Status: ${order.status}',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: order.status == 'Offen'
                                  ? Colors.orange
                                  : order.status == 'In Bearbeitung'
                                      ? Colors.blue
                                      : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
