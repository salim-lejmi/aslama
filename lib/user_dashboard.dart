import 'package:flutter/material.dart';
import '../database_helper.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    users = await DatabaseHelper.instance.queryAllUsers();
    setState(() {});
  }

  Future<void> _deleteUser(int userId) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete User'),
        content: Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await DatabaseHelper.instance.deleteUser(userId);
              _loadUsers();
              Navigator.pop(context);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('User Dashboard'),
    ),
    body: ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        if (user['username'] == 'admin') {
          return ListTile(
            title: Text('${user['username']} (${user['email']})'),
          );
        } else {
          return ListTile(
            title: Text('${user['username']} (${user['email']})'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteUser(user['id']),
            ),
          );
        }
      },
    ),
  );
}}