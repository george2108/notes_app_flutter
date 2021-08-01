import 'package:flutter/material.dart';
import 'package:notes_app/db/database_provider.dart';
import 'package:notes_app/models/password_model.dart';
import 'package:notes_app/widgets/menu_drawer.dart';

class PasswordsPage extends StatelessWidget {
  Future<List> getPasswords() async {
    final passwords = await DatabaseProvider.db.getAllPasswords();
    return passwords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis contraseñas'),
      ),
      drawer: Menu(),
      body: FutureBuilder(
        future: getPasswords(),
        builder: (context, AsyncSnapshot<List> passwordsData) {
          if (passwordsData.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (passwordsData.data!.length < 1) {
            return Center(
              child: Text('No tienes contraseñas aun, crea una'),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: passwordsData.data!.length,
                itemBuilder: (context, index) {
                  int id = passwordsData.data![index]['id'];
                  String title = passwordsData.data![index]['title'];
                  String user = passwordsData.data![index]['user'];
                  String password = passwordsData.data![index]['password'];
                  String description =
                      passwordsData.data![index]['description'];
                  String createdAt = passwordsData.data![index]['createdAt'];
                  return Card(
                    child: ListTile(
                      title: Text(title),
                      subtitle: Text(description),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          'showPassword',
                          arguments: PasswordModel(
                            id: id,
                            title: title,
                            user: user,
                            password: password,
                            description: description,
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'newPassword');
        },
      ),
    );
  }
}
