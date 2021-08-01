import 'package:flutter/material.dart';
import 'package:notes_app/db/database_provider.dart';
import 'package:notes_app/models/password_model.dart';
import 'package:notes_app/providers/password_provider.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  String title = '';
  String user = '';
  String password = '';
  String description = '';
  DateTime createdAt = DateTime.now();

  TextEditingController titleController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool ocultarPassword = true;

  addPassword(PasswordModel pass) {
    DatabaseProvider.db.addNewPassword(pass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva contraseña'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              setState(() {
                final passProvider = PasswordProvider();
                title = titleController.text.toString();
                user = userController.text.toString();
                // encripta la contraseña
                password =
                    passProvider.encrypt(passwordController.text.toString());
                description = descriptionController.text.toString();
                createdAt = DateTime.now();
              });
              PasswordModel passwordModel = PasswordModel(
                title: title,
                user: user,
                password: password,
                description: description,
                createdAt: createdAt,
              );
              addPassword(passwordModel);
              Navigator.pushNamedAndRemoveUntil(
                context,
                'passwords',
                (route) => false,
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Titulo de la contraseña',
                labelText: 'Titulo',
              ),
            ),
            SizedBox(height: 17.0),
            TextField(
              controller: userController,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Usuario',
                hintText: "Usuario de la cuenta",
              ),
            ),
            SizedBox(height: 17.0),
            TextField(
              controller: passwordController,
              maxLines: 1,
              obscureText: ocultarPassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    setState(() {
                      ocultarPassword = !ocultarPassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Contraseña',
                hintText: "Contraseña",
              ),
            ),
            SizedBox(height: 17.0),
            TextField(
              controller: descriptionController,
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Descipción de la contraseña",
                labelText: 'Descripción',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
