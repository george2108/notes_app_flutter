import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/models/password_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  late Database _database;

  List<String> consultas = [
    '''
        CREATE TABLE notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          body TEXT,
          createdAt TIMESTAMP
        )
      ''',
    '''
        CREATE TABLE passwords(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NULL,
          user TEXT NULL,
          password TEXT,
          description TEXT NULL,
          createdAt TIMESTAMP
        )
      '''
  ];

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "lubby.db"),
        onCreate: (db, version) async {
      for (String sql in consultas) {
        await db.execute(sql);
      }
    }, version: 1);
  }

  ///Notas
  addNewNote(NoteModel note) async {
    final db = await database;
    db.insert(
      "notes",
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List> getAllNotes() async {
    final db = await database;
    final res = await db.query("notes", orderBy: "createdAt DESC");
    if (res.length == 0) return [];
    final resultMap = res.toList();
    return resultMap.isNotEmpty ? resultMap : [];
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    int count = await db.rawDelete(
      "DELETE FROM notes WHERE id = ?",
      [id],
    );
    return count;
  }

  /// passwords
  Future<List> getAllPasswords() async {
    final db = await database;
    final res = await db.query("passwords", orderBy: "createdAt DESC");
    if (res.length == 0) return [];
    final resultMap = res.toList();
    return resultMap.isNotEmpty ? resultMap : [];
  }

  addNewPassword(PasswordModel pass) async {
    final db = await database;
    db.insert(
      "passwords",
      pass.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deletePassword(int id) async {
    final db = await database;
    int count = await db.rawDelete(
      "DELETE FROM passwords WHERE id = ?",
      [id],
    );
    return count;
  }
}
