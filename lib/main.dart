import 'package:flutter/material.dart';
import 'package:notes_app/pages/display_note.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/pages/new_note.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'newNote': (BuildContext context) => NewNote(),
        'showNote': (BuildContext context) => ShowNote(),
      },
    );
  }
}
