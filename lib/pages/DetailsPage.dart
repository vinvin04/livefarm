import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Details'),
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
