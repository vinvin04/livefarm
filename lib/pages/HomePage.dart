import 'package:flutter/material.dart';
import 'package:livefarm/pages/DetailsPage.dart';
import '../Globals.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('HomePage'),
        ),
        body: new ListView.builder
          (
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                selectedItem = index;
                print("index is "+ index.toString());
                print("selectedItem is "+ selectedItem.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsPage()),
                  );

                },
                child: ListTile(
                  leading:  Icon(
                      Icons.account_circle,
                      size: 50,
                  ),
                  title: Text(listItems[index]),
                  subtitle: Text("tap to view more"),
                ),
              );
            }
        )
    );
  }
}
