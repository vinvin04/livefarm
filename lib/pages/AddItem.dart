import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('AddItemPage'),
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
