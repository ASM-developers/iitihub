import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/services/firestore.dart';
import 'package:firstapp/services/models.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firstapp/services/gmail.dart';
import 'package:firstapp/profile/searchBar.dart';
import 'package:firstapp/news/news.dart';

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

  //stores the value of current user can be accessed using a constructor

  List<Student>? thing;

  //here lies the constructor which should be called upon clicking signin

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
            const DrawerHeader(
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
            ListTile(
              title: Text('NEWS'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => News()),
                ); // Handle settings press
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () => mailStreamliner().PrintMessages(
                    'in:inbox subject:night AND subject:canteen'),
                child: const Text('print msges')),
            ElevatedButton(
                onPressed: () async {
                  thing = await (FirestoreService().getStudentsByDept('H'));
                  if (thing != null) {
                    for (final i in thing ?? []) {
                      print(i.grad_yr);
                    }
                  }
                },
                child: Text('print searchQuery func')),
          ],
        ),

        // News(),
        // ListView(
        //   shrinkWrap: true,
        //   children: [News()],
        // ),
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
