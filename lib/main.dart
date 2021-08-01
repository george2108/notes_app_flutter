import 'package:flutter/material.dart';
import 'package:notes_app/pages/notes/display_note.dart';
import 'package:notes_app/pages/notes/edit_note.dart';
import 'package:notes_app/pages/notes/notes_page.dart';
import 'package:notes_app/pages/notes/new_note.dart';
import 'package:notes_app/pages/passwords/display_pass.dart';
import 'package:notes_app/pages/passwords/edit_pass.dart';
import 'package:notes_app/pages/passwords/new_password.dart';
import 'package:notes_app/pages/passwords/passwords_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'passwords',
      routes: {
        // notas
        'notes': (BuildContext context) => NotesPage(),
        'newNote': (BuildContext context) => NewNote(),
        'showNote': (BuildContext context) => ShowNote(),
        'editNote': (_) => EditNote(),

        // passwords
        'passwords': (BuildContext context) => PasswordsPage(),
        'newPassword': (BuildContext context) => NewPassword(),
        'showPassword': (BuildContext context) => ShowPassword(),
        'editPassword': (_) => EditPassword(),
      },
      theme: ThemeData(
        primaryColor: Color(0xFF227c9d),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF17C3B2),
        ),
      ),
    );
  }
}
