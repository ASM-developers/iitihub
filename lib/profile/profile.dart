// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/services/models.dart' as model;
import 'package:firstapp/news/new_input.dart';
import 'package:firstapp/Emails/MailList.dart';
// import 'package:firstapp/camap/camap.dart';
// import 'package:firstapp/prof/prof.dart';
import 'package:firstapp/prof/projects.dart';
import 'package:firstapp/profile/picture.dart';
import 'package:firstapp/services/firestore.dart';
import 'package:firstapp/services/models.dart' as lol;
import 'package:flutter/material.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:firstapp/services/gmail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/admin/admin.dart';
// import 'package:firstapp/admin/add_entity.dart';
import 'package:firstapp/services/models.dart' as model;
// import 'package:get/get.dart';
import 'package:googleapis/analyticsreporting/v4.dart';
// import 'package:googleapis/bigquery/v2.dart';
import 'package:firstapp/camap/common_example_wrapper.dart';
import 'package:firstapp/profile/searchBar.dart';
// import 'package:firstapp/news/news.dart';
import 'package:firstapp/prof/my_projects.dart';
// import 'dart:io';
// import 'package:provider/provider.dart';

// import 'package:firstapp/Emails/MessageDetiails.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:firstapp/services/firestore.dart';
// import 'package:firstapp/Emails/MessageDetiails.dart';

import '../news/news2.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// print(AuthServ);
bool isStudent = false;
bool adminval = false;

Future<void> checkUserType() async {
  if (AuthService().user == null) return;
  adminval = await FirestoreService().checkadmin(
    AuthService().user?.email,
  );
  isStudent = await FirestoreService().isStudent(AuthService().user?.email);
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

  Future<model.User> myself =
      FirestoreService().getUsersByEmail(AuthService().user?.email);
  @override
  void initState() {
    // print(AuthService().user==null);
    FirestoreService().createUser(
        AuthService().user?.email, AuthService().user?.displayName, context);
    super.initState();
  }

  lol.User? thing;

// print(myself) {
//   // TODO: implement print
//   throw UnimplementedError();
// }

  // final queryResult = ['a', 'b', 'ak', 'c'];
  @override
  Widget build(BuildContext context) {
    // sleep(const Duration(milliseconds: 2000));
    // print('inside build $adminval');
    // print(myself);
    checkUserType();
    // sleep(const Duration(milliseconds: 5000));
    // print('just before scaffold $adminval');

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                title: Text('EMAIL'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MailList(
                                buttonTexts: const {
                                  'TECH': [
                                    'Cynaptics',
                                    'Robotics',
                                    'IVDC',
                                    'PClub',
                                    'GDSC'
                                  ],
                                  'CULT': [
                                    'Kalakriti',
                                    'Aaina',
                                    'debsoc',
                                    'literary',
                                    'dance',
                                    'music'
                                  ],
                                  'CERP': ['CERP'],
                                  'SPORTS': [
                                    'Swimming',
                                    'Table',
                                    'Tennis',
                                    'Cricket'
                                  ],
                                  'Dinning': ['Ajay'],
                                  'Hostel': [
                                    'Room',
                                    'Hostel',
                                  ]
                                },
                              )));
                },
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
                    MaterialPageRoute(builder: (context) => News2()),
                  ); // Handle settings press
                },
              ),

              ListTile(
                  title: Text('MAP'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CommonExampleRouteWrapper(
                          imageProvider:
                              const AssetImage("assets/images/campus.png"),
                        ),
                      ),
                    );
                  }),
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

              if (AuthService().user != null) ...[
                FutureBuilder<bool>(
                    future: FirestoreService()
                        .checkadmin(AuthService().user?.email),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data == true &&
                          AuthService().user?.email != null) {
                        // print(AuthService().user);
                        // print("Admin");
                        // print(AuthService().user?.email);
                        return ListTile(
                          title: Text('ADMIN'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Admin()),
                            );
                          },
                        );
                      } else {
                        // print("not Admin");
                        // print(AuthService().user?.email);
                        return Container();
                      }
                    })
              ],
              FutureBuilder<model.User>(
                  future: FirestoreService()
                      .getUsersByEmail(AuthService().user?.email ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data?.type == 'professor' &&
                        AuthService().user?.email != null) {
                      return ListTile(
                        title: Text('MY PROJECTS'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProjectScreen()),
                          ); // Handle settings press
                        },
                      );
                    } else {
                      return Container();
                    }
                  }),

              // ListTile(
              //   title: Text('Add Enitties'),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => AddEntityScreen()),
              //     ); // Handle settings press
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: LoginButton(
                  text: 'Sign Out',
                  color: Colors.black45,
                  icon: FontAwesomeIcons.doorOpen,
                  loginMethod: AuthService().signOut,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.black54,
          child: Center(
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircularImage(
                    imageFile: 'assets/images/download.png',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(12, 12, 12, 1)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "The purpose of the project is to make an app for the college community. It can be used by college students and professors and even by administrations. This app will provide information and regular updates about any technical, cultural, academic and sports events, a platform for student-professor collaboration, and many more things. Thus acting as a bridge between the members of the institute community.",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  } //build
}
