import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile/Personal'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.note),
            title: Text('Goals/Set a goal'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.palette),
            title: Text('App Theme'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.food_bank),
            title: Text('My Custom Foods'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help?'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
