import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/services/firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfScreen extends StatefulWidget {
  ProfScreen({super.key});

  @override
  State<ProfScreen> createState() => _ProfScreenState();
}

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({super.key, required this.items});

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemvalue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemvalue);
      } else {
        _selectedItems.remove(itemvalue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Select tags"),
        content: SingleChildScrollView(
          child: ListBody(
            children: widget.items
                .map((item) => CheckboxListTile(
                      value: _selectedItems.contains(item),
                      title: Text(item),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (isChecked) => _itemChange(item, isChecked!),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(onPressed: _cancel, child: const Text("cancel")),
          TextButton(onPressed: _submit, child: const Text("submit")),
        ]);
  }
}

class _ProfScreenState extends State<ProfScreen> {
  List<String> _selectedItems = [];
  void _showmultiselect() async {
    final List<String> mylist = [
      'CSE',
      'AI/ML',
      'Competitive programming',
      'Material Science',
      'Civil',
      'Quantum Physics'
    ];

    final List<String>? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          items: mylist,
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedItems = result;
      });
    }
  }

  TextEditingController dateinput = TextEditingController();
  TextEditingController projname = TextEditingController();
  TextEditingController projdes = TextEditingController();
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    projname.text = ""; //set the initial value of text field
    projdes.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final projname = TextEditingController();
    // final projdes = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("professor dhishkau")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: projname,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Project Name',
                  hintText: 'Enter Project Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(height: 2.0),
                controller: projdes,
                minLines: 4,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Project Description',
                  labelStyle: TextStyle(),
                  hintText: 'Enter Project Description',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _showmultiselect();
                },
                child: Text("Add tags")),
            Wrap(
              children: _selectedItems
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Chip(
                          label: Text(e),
                        ),
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: dateinput, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      // print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      // print(formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput.text = formattedDate;//set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  }),
            ),
            ElevatedButton(
                onPressed: () {
                  final _projname = projname.text;
                  final _projdes = projdes.text;
                  final _tags = _selectedItems;
                  final _date1 = dateinput.text;
                  print(_date1);
                  FirestoreService().submitdata(
                      projname: _projname,
                      projdes: _projdes,
                      tags: _tags,
                      date: _date1);
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
  Future _submitdata(
      {required String projname,
      required String projdes,
      required List<String> tags,
      required String date}) async {
    final docuser = FirebaseFirestore.instance.collection('Projects').doc();
    final json = {
      'ID': docuser.id,
      'date': date,
      'description': projdes,
      'name': projname,
      'prof': AuthService().user?.email.toString(),
      'tags': tags,
    };
    await docuser.set(json);
}

}
