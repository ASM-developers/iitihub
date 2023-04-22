import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/prof/prof.dart';
import 'package:firstapp/prof/projects.dart';
import 'package:firstapp/profile/picture.dart';
import 'package:firstapp/services/firestore.dart';
import 'package:firstapp/services/models.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firstapp/services/gmail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/admin/admin.dart';

import 'package:get/get.dart';
import 'package:googleapis/analyticsreporting/v4.dart';
// import 'package:googleapis/bigquery/v2.dart';

import 'package:firstapp/profile/searchBar.dart';
import 'package:firstapp/news/news.dart';

import 'dart:io';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firstapp/services/firestore.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final data1 = TextEditingController();
  final data2 = TextEditingController();
  final data3 = TextEditingController();
  TextStyle robo = TextStyle(
      fontFamily: 'Roboto', fontSize: 16, color: Colors.orange.shade100);
  ButtonStyle lalpiwla = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black26),
    elevation: MaterialStatePropertyAll<double>(10),
  );
  Future<bool> check =
      FirestoreService().checkadmin(AuthService().user?.email.toString());
  // bool check2=check.get();

// int checkori = 0 ;
// int returncheckori(Future<bool> check){

//   if(check){
//     checkori
//   }
//   return checkori;
// }

  //stores the value of current user can be accessed using a constructor

  List<Student>? thing;

  //here lies the constructor which should be called upon clicking signin

  //sample queryResult thing to be fetched from the backend
  final queryResult = ['a', 'b', 'ak', 'c'];
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      FirestoreService().createUser(
          AuthService().user?.email, AuthService().user?.displayName, context);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                  delegate: SearchBar(FirestoreService().getUsersByName));
            },
            color: Colors.white,
            splashColor: Colors.white60,
            highlightColor: Colors.white30,
            tooltip: 'Search',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                padding: EdgeInsetsDirectional.fromSTEB(10, 20, 5, 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Text(
                  'Welcome to IITIHUB',
                  style: TextStyle(fontSize: 25, fontFamily: 'Roboto'),
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
              onTap: () {},
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
            ListTile(
              title: Text('PROJECTS'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProjectScreen()),
                ); // Handle settings press
              },
            ),
            ListTile(
              title: Text('ADD PROJECTS'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfScreen()),
                ); // Handle settings press
              },
            ),
            if (true) ...[
              ListTile(
                title: Text('Admin'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Admin()),
                  ); // Handle settings press
                },
              ),
            ],
            LoginButton(
              text: 'sign out',
              color: Colors.black45,
              icon: FontAwesomeIcons.doorOpen,
              loginMethod: AuthService().signOut,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.black54,
        child: Center(
          child: Container(
            width: 320,
            child: Column(children: [
              Center(
                child: CircularImage(
                  imageFile: 'assets/images/download.png',
                ),
              ),
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
                style: lalpiwla,
                onPressed: () async {
                  await FirestoreService().createStudent(
                      dept: data1.text, email: data2.text, grad_yr: data3.text);
                },
                child: Text(
                  'Submits',
                  style: robo,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: lalpiwla,
                      onPressed: () => mailStreamliner().PrintMessages(
                          'in:inbox subject:night AND subject:canteen'),
                      child: Text(
                        'PMSG',
                        style: robo,
                      )),
                  ElevatedButton(
                      style: lalpiwla,
                      onPressed: () async {
                        thing =
                            await (FirestoreService().getStudentsByDept('H'));
                        if (thing != null) {
                          for (final i in thing ?? []) {
                            print(i.grad_yr);
                          }
                        }
                      },
                      child: Text(
                        'PSQF',
                        style: robo,
                      )),
                ],
              ),

              // News(),
              // ListView(
              //   shrinkWrap: true,
              //   children: [News()],
              // ),
            ]),
          ),
        ),
      ),
    );
  }
}
