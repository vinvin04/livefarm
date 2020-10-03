import 'package:flutter/material.dart';
import 'package:livefarm/Globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  DateTime _dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('AddItemPage'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 10, 10),
                  child: Text(
                    'Date',
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Text(
                    _dateTime.day.toString() +
                        ' / ' +
                        _dateTime.month.toString() +
                        ' / ' +
                        _dateTime.year.toString(),
                    style: TextStyle(fontSize: fontSize),
                  ),
                )
              ],
            ),
            RaisedButton(
              child: Text(
                'Pick a date',
                style: TextStyle(fontSize: fontSize),
              ),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: _dateTime,
                        firstDate: DateTime(2019),
                        lastDate: DateTime(2021))
                    .then((date) {
                  setState(() {
                    if (date == null) {
                      _dateTime = DateTime.now();
                    } else {
                      _dateTime = date;
                    }
                  });
                });
              },
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 10, 10),
                  child: Text(
                    'Select',
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
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
                          child: Text("Medicine"),
                          value: 2,
                        ),
                        DropdownMenuItem(child: Text("fertility"), value: 3),
                        DropdownMenuItem(child: Text("purchase"), value: 4)
                      ],
                      onChanged: (value) {
                        setState(() {
                          globalValue = value;
                        });
                      }),
                ),
              ],
            ),
            Builder(
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
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: displayTitles[globalValue]['title'],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              gapPadding: 18),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: subtitleController,
                        decoration: InputDecoration(
                          labelText: displayTitles[globalValue]['subtitle'],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              gapPadding: 18),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      OutlineButton(
                        onPressed: () {
                          _handlePostResource(context);
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

  _handlePostResource(context) {
    print(nameController.value.text);
    print(titleController.value.text);
    print(subtitleController.value.text);
    Scaffold.of(context).showSnackBar(SnackBar(content: Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 25, 5),
          child: CircularProgressIndicator(),
        ),
        Text('Posting Data',style: TextStyle(fontSize: fontSize))
      ],
    )));
    Firestore.instance.collection('livestock').add({
      "date": _dateTime.day.toString() +
          '/' +
          _dateTime.month.toString() +
          '/' +
          _dateTime.year.toString(),
      "value": globalValue,
      "name": nameController.value.text,
      displayTitles[globalValue]['title']: titleController.value.text,
      displayTitles[globalValue]['subtitle']: subtitleController.value.text,
      'timestamp': DateTime.now().toString(),
    });
  }
}
