import 'package:farmx/services/shared_preferences.dart';
import 'package:farmx/views/my_orders_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.username, required this.email}) : super(key: key);
  final String username;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Text(username),
          UserAccountsDrawerHeader(
            accountName: Text(username),
            accountEmail: Text(email.isNotEmpty ? email : "email@placeholder"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text("A", style: TextStyle(fontSize: 40.0),), //TODO: add image
            ),
            decoration:BoxDecoration(
              color: Colors.teal[700],
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Update the state of the app.
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: const Text('My Orders'),
            onTap: () {
              Navigator.pushNamed(context, '/orders');
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              // Update the state of the app.
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: const Text('Help Center'),
            onTap: () {
              // Update the state of the app.
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Update the state of the app.
              // ...
              SharedPrefrence().clear();
              Navigator.pushNamed(context, '/login');
              // Then close the drawer
            },
          ),
        ],
      ),
    );
  }
}