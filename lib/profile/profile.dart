import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/services/firestore.dart';
import 'package:firstapp/services/models.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firstapp/services/gmail.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final data1 = TextEditingController();
  final data2 = TextEditingController();
  final data3 = TextEditingController();
  List<String>? thing;

  //sample queryResult thing to be fetched from the backend
  final queryResult = ['a', 'b', 'ak', 'c'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text('Hello ${AuthService().user?.displayName}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBar(queryResult),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('ABOUT'),
              onTap: () {
                // Handle about press
              },
            ),
            ListTile(
              title: Text('SETTINGS'),
              onTap: () {
                // Handle settings press
              },
            ),
            LoginButton(
              text: 'sign out',
              color: Colors.black45,
              icon: FontAwesomeIcons.doorOpen,
              loginMethod: AuthService().signOut,
            ),
          ],
        ),
      ),
      body: Column(children: [
        Center(
            child: CircularImage(
          imageFile: 'assets/images/download.png',
        )),
        TextField(
          controller: data1,
        ),
        TextField(
          controller: data2,
        ),
        TextField(
          controller: data3,
        ),
        ElevatedButton(
          onPressed: () async {
            await createUser(
                dept: data1.text, email: data2.text, grad_yr: data3.text);
          },
          child: const Text('Submits'),
        ),
        ElevatedButton(
            onPressed: () => mailStreamliner()
                .PrintMessages('in:inbox subject:night AND subject:canteen'),
            child: const Text('print msges')),
        ElevatedButton(
            onPressed: () async {
              thing = await (FirestoreService().getResults('h'));
              if (thing != null) {
                for (final i in thing ?? []) {
                  print(i.grad_yr);
                }
              }
            },
            child: Text('print searchQuery func'))
      ]),
    );
  }

  Future createUser({
    required String dept,
    required String email,
    required String grad_yr,
  }) async {
    final docuser = FirebaseFirestore.instance.collection('student').doc();
    final json = {
      'ID': docuser.id,
      'dept': dept,
      'email': email,
      'grad_yr': grad_yr,
    };
    await docuser.set(json);
  }
}

class SearchBar extends SearchDelegate {
  final List<String> queryResult;

  SearchBar(this.queryResult);

  @override
  //manipulation of tags should be done from here
  //remember if query's last character is # then listen for the next whitespace and add the tag into search list
  //also make a tag results column too
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
        queryResult.where((item) => item.startsWith(query)).toList();

    if (results.isEmpty) {
      return const Center(
        child: Text(
          'No results found.',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          final result = results[index];
          return ListTile(
            title: Text(result),
            onTap: () {
              // Handle result selection
            },
          );
        },
      );
    }
  }

  @override
  //optionally wrapping in a futurebuilder to listen to streams
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : queryResult.where((item) => item.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        //here you can change what happens when someone clicks on an object rendered by query
        //TODO : on encountering a # await a whitespace to add to the list of tags with which we fetch a list of projects
        onTap: () {
          query = suggestionList[index];
          showResults(context);
        },
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
}

class CircularImage extends StatelessWidget {
  final String imageFile;
  final double size;

  CircularImage({Key? key, required this.imageFile, this.size = 100.0})
      : super(key: key);

  @override
  //when we are able to fetch image uri from backend replace the placeholder with Image.fronUri() and add the text obtained in imageFile
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        imageFile,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
