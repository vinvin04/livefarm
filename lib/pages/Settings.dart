import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: const Center(
        child: Text(
          'This is the AddItem page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
