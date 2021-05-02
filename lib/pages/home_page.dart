import 'package:flutter/material.dart';

import 'package:notes_app/db/database_provider.dart';
import 'package:notes_app/models/note_model.dart';

class HomePage extends StatelessWidget {
  getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis notas'),
      ),
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
                    return Card(
                      child: ListTile(
                        title: Text(title),
                        subtitle: Text(body),
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
