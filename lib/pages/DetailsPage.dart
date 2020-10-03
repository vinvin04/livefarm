import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livefarm/pages/HomePage.dart';
import '../Globals.dart';
import '../horizontal_data_table/horizontal_data_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livefarm/pages/AddItem.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // int globalValue = 1;
  var loaded = false;
  var postsLength;

  var posts = [[], [], [], [], []];

  initState() {
    super.initState();
    debugPrint("##### Init state called");
    getData();
  }

  void getData() {
    Firestore.instance.collection('livestock').getDocuments().then((doc) {
      // posts = [];
      var temp = doc.documents;
      print(temp);
      for (var p in temp) {
        print("Data ${p.data}");
        posts[p.data['value']].add(p.data);
      }
      print(posts[globalValue].length);
      print(posts);
      setState(() {
        loaded = true;
        postsLength = posts[globalValue].length;
        debugPrint("getPosts called");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                posts = [[], [], [], [], []];
                setState(() {
                  loaded = false;
                  getData();
                });
              },
              child: Icon(Icons.refresh),
            ),
          ],

          title: Text(
              selectedItem.toString() + " item " + listItems[selectedItem]),
        ),
        body: loaded
            ? LiquidPullToRefresh(
          onRefresh: (){
            return Future<void>((){
              posts = [[], [], [], [], []];;
              print("--------Pulled to refresh at --------");
              getData();
            });
          },
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 1, 1, 1),
                    child: DropdownButton(
                        value: globalValue,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              "Milk",
                              style: TextStyle(fontSize: 25),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                              child: Text("Medicine"), value: 2),
                          DropdownMenuItem(
                              child: Text("fertility"), value: 3),
                          DropdownMenuItem(
                              child: Text("purchase"), value: 4)
                        ],
                        onChanged: (value) {
                          setState(() {
                            globalValue = value;
                          });
                        }),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      print("in");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddItem()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 1, 1, 1),
                      child: Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              _getBodyWidget(),
            ],
          ),
        )
            : Center(child: CircularProgressIndicator()));
  }

  Widget _getBodyWidget() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 300,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: posts[globalValue].length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
      ),
      height: MediaQuery.of(context).size.height - 134,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Date', 100),
      _getTitleItemWidget(displayTitles[globalValue]['title'], 100),
      _getTitleItemWidget(displayTitles[globalValue]['subtitle'], 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(posts[globalValue][index]['date']),
      width: 130,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    switch (globalValue) {
      case 1:
        return _generateMilk(context, index);
      case 2:
        return _generateMedicine(context, index);
      case 3:
        return _generateFertility(context, index);
      case 4:
        return _generatePurchase(context, index);
    }
    return Text('something went wrong');
  }

  Widget _generateMilk(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(posts[globalValue][index]['Milk']),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(posts[globalValue][index]['session']),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Widget _generateMedicine(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(posts[globalValue][index]['medicine']),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(posts[globalValue][index]['dosage']),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Widget _generateFertility(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(posts[globalValue][index]['fertility']),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(posts[globalValue][index]['breed']),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Widget _generatePurchase(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(posts[globalValue][index]['Purchase']),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(posts[globalValue][index]['vendor']),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
