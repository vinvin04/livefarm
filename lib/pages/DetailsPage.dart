import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Globals.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title:
            Text(selectedItem.toString() + " item " + listItems[selectedItem]),
      ),
      body: Container(
            // height: 400.0,
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.vertical,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // selectedItem = index;
                      print("index is " + index.toString());
                    },
                    child: index == 0 ? Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 1, 1, 1),
                          child: DropdownButton(
                              value: _value,
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    "First Item",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Second Item"),
                                  value: 2,
                                ),
                                DropdownMenuItem(child: Text("Third Item"), value: 3),
                                DropdownMenuItem(child: Text("Fourth Item"), value: 4)
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 1, 1, 1),
                          child: Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ) : ListTile(
                      leading: Text('24/58/1235'),
                      title: Text('12.5L'),
                    ),
                  );
                }),
          ),


    );
  }
}
