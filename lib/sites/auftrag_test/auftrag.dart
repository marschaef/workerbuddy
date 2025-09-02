// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_import, dead_code, unused_element, unnecessary_cast, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, invalid_null_aware_operator, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Container Auftrag() {
  return Container(
    // project://lib\sites\auftrag_test\auftrag.pug#2,5
    child: Row(
      // project://lib\sites\auftrag_test\auftrag.pug#3,9
      children: __flatten([
        Container(
          // project://lib\sites\auftrag_test\auftrag.pug#4,13
          child: Column(
            // project://lib\sites\auftrag_test\auftrag.pug#5,17
            children: __flatten([
              //-- AUFTRAG-ERSTELLEN ----------------------------------------------------------
              ElevatedButton(
                // project://lib\sites\auftrag_test\auftrag.pug#6,21
                onPressed: () {
                  print("Click!");
                },
                // Workaround über .pug Datei
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[300],
                  foregroundColor: Colors.black,
                  textStyle: TextStyle(fontSize: 12),
                ),
                child: const Text('Auftrag erstellen'),
              ),
              //-- ERSTELLTE-AUFTRAEGE ----------------------------------------------------------
              Text(
                // project://lib\sites\auftrag_test\auftrag.pug#8,21
                'Erstellte Aufträge',
              ),
              //-- ERTEILTE-AUFTRAEGE ----------------------------------------------------------
              ElevatedButton(
                // project://lib\sites\auftrag_test\auftrag.pug#9,21
                onPressed: () {
                  print("Click!");
                },
                fontSize:
                    13, // müsste in textStyle: TextStyle(fontSize: 13) übersetzt werden
                child: Text(
                  // project://lib\sites\auftrag_test\auftrag.pug#10,25
                  'erteilte Aufträge',
                ),
                backgroundColor: Colors
                    .blue, // müsste in style: ElevatedButton.styleFrom(backgroundColor: Colors.blue) übersetzt werden
              ),
              TextButton(
                // project://lib\sites\auftrag_test\auftrag.pug#11,21
                onPressed: () {
                  print("Click!");
                },
                child: Text(
                  // project://lib\sites\auftrag_test\auftrag.pug#12,25
                  'Eigene',
                ),
              ),
              TextButton(
                // project://lib\sites\auftrag_test\auftrag.pug#13,21
                onPressed: () {
                  print("Click!");
                },
                child: Text(
                  // project://lib\sites\auftrag_test\auftrag.pug#14,25
                  'für Kunden',
                ),
              ),
              TextButton(
                // project://lib\sites\auftrag_test\auftrag.pug#15,21
                onPressed: () {
                  print("Click!");
                },
                child: Text(
                  // project://lib\sites\auftrag_test\auftrag.pug#16,25
                  'Angebote',
                ),
              ),
              TextButton(
                // project://lib\sites\auftrag_test\auftrag.pug#17,21
                onPressed: () {
                  print("Click!");
                },
                child: Text(
                  // project://lib\sites\auftrag_test\auftrag.pug#18,25
                  'Express',
                ),
              ),
              TextButton(
                // project://lib\sites\auftrag_test\auftrag.pug#19,21
                onPressed: () {
                  print("Click!");
                },
                child: Text(
                  // project://lib\sites\auftrag_test\auftrag.pug#20,25
                  'Standard',
                ),
              ),
              TextButton(
                // project://lib\sites\auftrag_test\auftrag.pug#21,21
                onPressed: () {
                  print("Click!");
                },
                child: Text(
                  // project://lib\sites\auftrag_test\auftrag.pug#22,25
                  'Beobachtete Aufträge',
                ),
              ),
              TextButton(
                // project://lib\sites\auftrag_test\auftrag.pug#23,21
                onPressed: () {
                  print("Click!");
                },
                child: Text(
                  // project://lib\sites\auftrag_test\auftrag.pug#24,25
                  'Marktplatz',
                ),
              ),
              Text(
                // project://lib\sites\auftrag_test\auftrag.pug#25,21
                'Aktive Aufträge',
              ),
              TextButton(
                // project://lib\sites\auftrag_test\auftrag.pug#26,21
                onPressed: () {
                  print("Click!");
                },
                child: Text(
                  // project://lib\sites\auftrag_test\auftrag.pug#27,25
                  'eigene Aufträge',
                ),
              ),
              TextButton(
                // project://lib\sites\auftrag_test\auftrag.pug#28,21
                onPressed: () {
                  print("Click!");
                },
                child: Text(
                  // project://lib\sites\auftrag_test\auftrag.pug#29,25
                  'Kunden Aufträge',
                ),
              ),
              TextButton(
                // project://lib\sites\auftrag_test\auftrag.pug#30,21
                onPressed: () {
                  print("Click!");
                },
                child: Text(
                  // project://lib\sites\auftrag_test\auftrag.pug#31,25
                  'Work',
                ),
              ),
            ]),
          ),
        ),
      ]),
    ),
  );
}

__flatten(List list) {
  return List<Widget>.from(
    list.expand((item) {
      return item is Iterable ? item : [item as Widget];
    }),
  );
}
