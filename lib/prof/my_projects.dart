import 'package:firstapp/services/firestore.dart';
import 'package:firstapp/services/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/services/models.dart';
import 'package:firstapp/prof/details.dart';
import 'package:firstapp/services/firestore.dart';
// import 'package:firstapp/prof/prof.dart';
// FirestoreService ins= FirestoreService()

class MyProjectScreen extends StatefulWidget {
  const MyProjectScreen({super.key});

  @override
  State<MyProjectScreen> createState() => _MyProjectScreenState();
}

class MultiSelect extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onSelectedTagsChanged; // add this line
  const MultiSelect(
      {super.key, required this.items, required this.onSelectedTagsChanged});

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
    widget.onSelectedTagsChanged(_selectedItems);
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

class _MyProjectScreenState extends State<MyProjectScreen> {
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
          onSelectedTagsChanged: (tags) {
            setState(() {
              _selectedTags = tags;
            });
            searchProject(
                searchtext.text); // call searchProject to update the stream
          },
        );
      },
    );
    if (result != null) {
      setState(() {
        _selectedTags = result;
      });
    }
  }

  Stream<List<Projects>> _projectStream = FirestoreService()
      .getmyprojectbyTag([], '');
  List<String> _selectedTags = [];
  TextEditingController searchtext = TextEditingController();
  void searchProject(String searchText) {
    setState(() {
      _projectStream =
          FirestoreService().getmyprojectbyTag(_selectedTags, searchText);
    });
  }
  ButtonStyle lalpiwla = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black26),
    elevation: MaterialStatePropertyAll<double>(10),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Projects"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: searchtext,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "search project",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: searchProject,
              ),
            ),
            ElevatedButton(
                style: lalpiwla,
                onPressed: () {
                  _showmultiselect();
                },
                child: Text("Add tags")),
            Wrap(
              children: _selectedTags
                  .map((e) => Padding(
                padding: const EdgeInsets.all(3.0),
                child: Chip(
                  label: Text(e),
                ),
              ))
                  .toList(),
            ),
            Flexible(
              child: StreamBuilder<List<Projects>>(
                stream: _projectStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("something is wrong");
                  } else if (snapshot.hasData) {
                    final projects = snapshot.data;
                    return ListView(
                      children: projects!.map(buildProject).toList(),
                    );
                  } else {
                    return Text("empty");
                  }
                },
              ),
            ),
          ],
        ));
  }

  Widget buildProject(Projects projects) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: ListTile(
      // leading: (Icon(Icons.person_pin_circle_sharp)),
      title: Text(projects.name),
      subtitle: Text(projects.prof),
      trailing: (Icon(Icons.menu)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Color.fromRGBO(228, 228, 247, 0.494),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(project: projects),
            ));
      },
    ),
  );
}
