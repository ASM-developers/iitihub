// import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/services/firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:multiselect/multiselect.dart';
import 'package:intl/intl.dart';



class AddEntityScreen extends StatefulWidget {
  AddEntityScreen({super.key});

  @override
  State<AddEntityScreen> createState() => _AddEntityScreenState();
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

class _AddEntityScreenState extends State<AddEntityScreen> {

  List<String> _selectedItems = [];
  void _showmultiselect() async {
    final List<String> mylist = [
      'Dining',
      'Hostels',
      'Technical',
      'Sports',
      'Cultural',
      'CERP/Talks'
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

  TextEditingController assocTags = TextEditingController();
  TextEditingController entityname = TextEditingController();
  TextEditingController entityemail = TextEditingController();

  @override
  void initState() {
    assocTags.text = ""; //set the initial value of text field
    entityname.text = ""; //set the initial value of text field
    entityemail.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {





    return Scaffold(
      appBar: AppBar(title: const Text("Add New Entity")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: entityname,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Entity Name',
                  hintText: 'Cynaptics Club , IVDC Club, etc',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(height: 2.0),
                controller: entityemail ,
                minLines: 1,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Entity email',
                  labelStyle: TextStyle(),
                  hintText: 'ivdc@iiti.ac.in',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _showmultiselect();
                },
                child: Text("Add associated Tags")),
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

          ElevatedButton(
                onPressed: () {
                  final _entityname = entityname.text;
                  final _entityemail = entityemail.text;
                  final _tags = _selectedItems;

                  FirestoreService().submitEntitydata(
                      entityname: _entityname,
                      entityemail: _entityemail,
                      tags: _tags,);
                },
                child: Text("Submit Entity"))
          ],
        ),
      ),
    );
  }
}
