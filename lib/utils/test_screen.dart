import 'package:flutter/material.dart';
import 'package:worker_buddy/utils/app_styles.dart';

void main() => runApp(const StyleTestApp());

class StyleTestApp extends StatefulWidget {
  const StyleTestApp({super.key});

  @override
  State<StyleTestApp> createState() => _StyleTestAppState();
}

class _StyleTestAppState extends State<StyleTestApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Style Test',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: StyleTestPage(onThemeChanged: _toggleTheme),
    );
  }
}

class StyleTestPage extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  const StyleTestPage({super.key, required this.onThemeChanged});

  @override
  State<StyleTestPage> createState() => _StyleTestPageState();
}

class _StyleTestPageState extends State<StyleTestPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Test'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.paddingMedium),
        children: [
          // -- Theme-Umschalter --
          SwitchListTile(
            title: Text('Dark Mode', style: textTheme.bodyLarge),
            value: theme.brightness == Brightness.dark,
            onChanged: widget.onThemeChanged,
            secondary: Icon(theme.brightness == Brightness.dark
                ? Icons.dark_mode
                : Icons.light_mode),
          ),
          const Divider(height: AppTheme.paddingLarge),

          // -- Farbschema --
          Text('Farben (ColorScheme)', style: textTheme.headlineLarge),
          const SizedBox(height: AppTheme.paddingSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColorCircle(colorScheme.primary, 'Primary'),
              _buildColorCircle(colorScheme.secondary, 'Secondary'),
              _buildColorCircle(colorScheme.surface, 'Surface'),
              _buildColorCircle(colorScheme.onSurface, 'On Surface'),
              _buildColorCircle(colorScheme.error, 'Error'),
            ],
          ),
          const SizedBox(height: AppTheme.paddingLarge),

          // -- Text-Stile --
          Text('Text-Stile (TextTheme)', style: textTheme.headlineLarge),
          const SizedBox(height: AppTheme.paddingSmall),
          Text('Headline Large', style: textTheme.headlineLarge),
          const SizedBox(height: AppTheme.paddingSmall),
          Text('Headline Medium', style: textTheme.headlineMedium),
          const SizedBox(height: AppTheme.paddingSmall),
          Text(
              'Body Large. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              style: textTheme.bodyLarge),
          const SizedBox(height: AppTheme.paddingSmall),
          Container(
            color: colorScheme.primary,
            padding: const EdgeInsets.all(AppTheme.paddingSmall),
            child: Text('Label Large (für Buttons etc.)',
                style: textTheme.labelLarge),
          ),
          const SizedBox(height: AppTheme.paddingLarge),

          // -- Buttons und Container --
          Text('Komponenten', style: textTheme.headlineLarge),
          const SizedBox(height: AppTheme.paddingSmall),
          ElevatedButton(
            onPressed: () {},
            child: const Text('ElevatedButton'),
          ),
          const SizedBox(height: AppTheme.paddingMedium),
          // Verwendung einer Card, um die cardTheme zu testen
          const Card(
            child: Padding(
              padding: EdgeInsets.all(AppTheme.paddingMedium),
              child: Text(
                'Dies ist eine Card, die die cardTheme aus AppTheme verwendet.',
              ),
            ),
          ),
          const SizedBox(height: AppTheme.paddingLarge),

          // -- Benutzerdefinierte Dekorationen --
          Text('Benutzerdefinierte Stile', style: textTheme.headlineLarge),
          const SizedBox(height: AppTheme.paddingSmall),
          // Der Gradient wird hier dynamisch erstellt, um im Light- und Dark-Mode zu funktionieren.
          Container(
            padding: const EdgeInsets.all(AppTheme.paddingMedium),
            decoration: AppTheme.getBackgroundGradient(colorScheme),
            child: const Text(
              'Container mit themen-abhängigem Gradient',
            ),
          ),
          const SizedBox(height: AppTheme.paddingMedium),
          Container(
            padding: const EdgeInsets.all(AppTheme.paddingMedium),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              boxShadow: AppTheme.getCardShadow(theme.brightness),
            ),
            child: Text(
              'Container mit manuellem getCardShadow()',
              // Weist dem Text im Dark Mode explizit eine dunkle Farbe zu.
              style: theme.brightness == Brightness.dark
                  ? TextStyle(color: AppTheme.lightTheme.colorScheme.onSurface)
                  : null,
            ),
          ),
          const SizedBox(height: AppTheme.paddingLarge),

          // -- Formular-Elemente --
          Text('Formular-Elemente', style: textTheme.headlineLarge),
          const SizedBox(height: AppTheme.paddingSmall),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Label Text',
              hintText: 'Ein TextField, um inputDecorationTheme zu testen',
            ),
          ),
          const SizedBox(height: AppTheme.paddingLarge),
        ],
      ),
    );
  }

  // Hilfs-Widget, um einen Farbkreis darzustellen
  Widget _buildColorCircle(Color color, String name) {
    final textStyle = Theme.of(context).textTheme.bodySmall;
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(51)), // 0.2 opacity
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: textStyle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}