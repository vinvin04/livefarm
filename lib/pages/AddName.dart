import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Globals.dart';

class AddNamePage extends StatefulWidget {
  @override
  _AddNamePageState createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddNamePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('AddItemPage'),
        ),
        body: Column(
          children: [
            // Expanded(
            //   flex: 4,
            //   child:
              Container(
                height: 150,
                padding: EdgeInsets.fromLTRB(25, 15, 15, 15),
                child: Builder(
                  builder: (context) => Center(
                    child: Form(
                      key: _formKey,
                      autovalidate: true,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: "name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  gapPadding: 18),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          OutlineButton(
                            padding: EdgeInsets.fromLTRB(15, 5, 5, 0),
                            onPressed: () {
                              _handleAddName(context);
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            // ),
            Expanded(
              flex: 10,
              child: Container(
                child: StreamBuilder(
                    stream: Firestore.instance.collection('names').snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.builder(
                          padding: const EdgeInsets.all(8),
                          scrollDirection: Axis.vertical,
                          itemCount:
                              snapshot.data.documents[0].data['names'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 50,
                              child: ListTile(
                                title: Text(snapshot
                                    .data.documents[0].data['names'][index]),
                              ),
                            );
                          });
                      // print(snapshot.data.documents[0].data['names']);
                      // return Text("kldsfk");
                    }),
              ),
            )
          ],
        ));
  }

  _handleAddName(context) {
    print(nameController.value.text);
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 25, 5),
          child: CircularProgressIndicator(),
        ),
        Text('Posting Name', style: TextStyle(fontSize: fontSize))
      ],
    )));
    Firestore.instance.collection("names").getDocuments().then((value) {
      var list = List<String>();
      list.add(nameController.value.text);
      Firestore.instance
          .collection('names')
          .document(value.documents[0].documentID)
          .updateData({"names": FieldValue.arrayUnion(list)});
    });
    // Firestore.instance.collection('Users').document(data.documents[0].documentID).updateData({"bookmarks": FieldValue.arrayUnion(list)});
  }
}
