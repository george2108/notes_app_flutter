import 'package:flutter/material.dart';
import 'package:notes_app/db/database_provider.dart';

import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/menu_drawer.dart';

class NotesPage extends StatelessWidget {
  getNotes() async {
    final notes = await DatabaseProvider.db.getAllNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis notas'),
      ),
      drawer: Menu(),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, notesData) {
          if (notesData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (notesData.data == Null) {
              return Center(
                child: Text('No tienes notas aun, crea una'),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: notesData.data.length,
                  itemBuilder: (context, index) {
                    int id = notesData.data[index]['id'];
                    String title = notesData.data[index]['title'];
                    String body = notesData.data[index]['body'];
                    String createdAt = notesData.data[index]['createdAt'];
                    String newBody;
                    if (body.length > 59)
                      newBody = body.substring(1, 60) + '...';
                    return Nota(
                      title: title,
                      body: body,
                      newBody: newBody,
                      id: id,
                      createdAt: createdAt,
                    );
                  },
                ),
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add),
        onPressed: () {
          Navigator.pushNamed(context, 'newNote');
        },
      ),
    );
  }
}

// muestra las notas en el listado
class Nota extends StatelessWidget {
  const Nota({
    Key key,
    @required this.title,
    @required this.body,
    @required this.newBody,
    @required this.id,
    @required this.createdAt,
  }) : super(key: key);

  final String title;
  final String body;
  final String newBody;
  final int id;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(body.length > 59 ? newBody : body),
        onTap: () {
          Navigator.pushNamed(
            context,
            'showNote',
            arguments: NoteModel(
              title: title,
              body: body,
              id: id,
              createdAt: DateTime.parse(createdAt),
            ),
          );
        },
      ),
    );
  }
}
