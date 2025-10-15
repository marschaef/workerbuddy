import 'package:flutter/material.dart';

class NavigationItem {
  final String title;
  final int index;
  final IconData? icon;

  NavigationItem({required this.title, required this.index, this.icon});
}

final List<NavigationItem> navigationItems = [
  NavigationItem(title: 'Aufträge', index: 1, icon: Icons.work),
  NavigationItem(title: 'Profil', index: 2, icon: Icons.person),
  NavigationItem(title: 'Termine', index: 3, icon: Icons.calendar_today),
  NavigationItem(title: 'Nachrichten', index: 4, icon: Icons.message),
  NavigationItem(title: 'Kontakte', index: 5, icon: Icons.contacts),
  NavigationItem(title: 'Abrechnung', index: 6, icon: Icons.receipt_long),
  NavigationItem(title: 'Worker', index: 7, icon: Icons.engineering),
  NavigationItem(title: 'Kunden', index: 8, icon: Icons.business),
];
