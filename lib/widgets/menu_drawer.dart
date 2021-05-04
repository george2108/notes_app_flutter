import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Header(),
          ListTile(
            title: Text('Contraseñas'),
            leading: Icon(
              Icons.vpn_key,
              color: Colors.orange,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'passwords', (route) => false);
            },
          ),
          ListTile(
            title: Text('Notas'),
            leading: Icon(
              Icons.note,
              color: Colors.cyan,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'notes', (route) => false);
            },
          ),
          ListTile(
            title: Text('TODO'),
            leading: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF227c9d),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://pbs.twimg.com/profile_images/1018943227791982592/URnaMrya.jpg'),
            radius: 50.0,
          ),
          SizedBox(height: 15.0),
          Text('Luby')
        ],
      ),
    );
  }
}
