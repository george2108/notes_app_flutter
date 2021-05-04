import 'package:flutter/material.dart';
import 'package:notes_app/db/database_provider.dart';
import 'package:notes_app/models/password_model.dart';
import 'package:notes_app/providers/password_provider.dart';

class ShowPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PasswordModel pass =
        ModalRoute.of(context).settings.arguments as PasswordModel;

    final passProvider = PasswordProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text('Nota'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              DatabaseProvider.db.deletePassword(pass.id);
              Navigator.pushNamedAndRemoveUntil(
                context,
                "passwords",
                (route) => false,
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              pass.title,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              pass.user,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              passProvider.decrypt(pass.password),
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              pass.description,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
