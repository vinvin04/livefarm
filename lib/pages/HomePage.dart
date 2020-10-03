import 'package:flutter/material.dart';
import 'package:livefarm/pages/DetailsPage.dart';
import '../Globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var homePageLoaded = false;
  initState(){
    super.initState();
    debugPrint("##### Init state called");
    getNames();
  }

  void getNames() {
    Firestore.instance.collection('names').getDocuments().then((doc) {
      var temp = doc.documents;
      print(temp);
      for(var t in temp) {
        print(t.data);
        names = t.data['names'];
      }
      print(names);
      setState(() {
        homePageLoaded = true;
        debugPrint("getdata called");
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('HomePage'),
        ),
        body: names.length > 0 ? new ListView.builder
          (
            itemCount: names.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  selectedItem = index;
                  // print("index is "+ index.toString());
                  // print("selectedItem is "+ selectedItem.toString());
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
                  title: Text(names[index]),
                  subtitle: Text("tap to view more"),
                ),
              );
            }
        ) : Center(child: CircularProgressIndicator())
    );
  }
}
