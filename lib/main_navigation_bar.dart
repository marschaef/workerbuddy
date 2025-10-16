import 'package:flutter/material.dart';

class MainNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize =
      const Size.fromHeight(90);

  final int currentIndex;
  final String currentTitle;
  final Function(int) onIndexChanged;
  final Function(String) onTitleChanged;

  const MainNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
    required this.currentTitle,
    required this.onTitleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      // Hamburger-Menü für die mobile Navigation
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: InkWell(
        onTap: () {
          onIndexChanged(0);
          onTitleChanged('Home | WorkerBuddy');
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              0,
              20,
              0,
              10,
            ),
            child: Image.asset(
              'assets/images/WorkerBuddy_kurz_neu.png',
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            0,
            10,
            30,
            10,
          ),
          child: IconButton(
            icon: const Icon(Icons.login),
            tooltip: 'Login',
            onPressed: () {
              onIndexChanged(9);
              onTitleChanged(
                'Login | WorkerBuddy',
              );
            },
          ),
        ),
      ],
      // Keine untere Navigationsleiste in der mobilen Ansicht
      // bottom: const PreferredSize(
      //   preferredSize: Size.fromHeight(0),
      //   child: SizedBox.shrink(),
      // ),
      // shape: Border(
      //   top: BorderSide(color: theme.colorScheme.primary, width: 3),
      //   left: BorderSide(color: theme.colorScheme.primary, width: 3),
      //   right: BorderSide(color: theme.colorScheme.primary, width: 3),
      // ),
    );
  }
}
