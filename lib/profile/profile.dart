import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/news/new_input.dart';
import 'package:firstapp/Emails/MailList.dart';
import 'package:firstapp/camap/camap.dart';
import 'package:firstapp/prof/prof.dart';
import 'package:firstapp/prof/projects.dart';
import 'package:firstapp/profile/picture.dart';
import 'package:firstapp/services/firestore.dart';
import 'package:firstapp/services/models.dart' as lol;
import 'package:flutter/material.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firstapp/services/gmail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/admin/admin.dart';
import 'package:firstapp/admin/add_entity.dart';
import 'package:firstapp/services/models.dart';
import 'package:get/get.dart';
import 'package:googleapis/analyticsreporting/v4.dart';
// import 'package:googleapis/bigquery/v2.dart';
import 'package:firstapp/camap/common_example_wrapper.dart';
import 'package:firstapp/profile/searchBar.dart';
import 'package:firstapp/news/news.dart';

import 'dart:io';
import 'package:provider/provider.dart';

import 'package:firstapp/Emails/MessageDetiails.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firstapp/services/firestore.dart';
import 'package:firstapp/Emails/MessageDetiails.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
// print(AuthServ);
bool isStudent = false;
bool adminval = false;

Future<void> checkUserType() async {
  if(AuthService().user==null) return;
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

  @override
  void initState() {
    print(AuthService().user==null);
    FirestoreService().createUser(
        AuthService().user?.email, AuthService().user?.displayName, context);
    super.initState();
  }

  lol.User? thing;

  final queryResult = ['a', 'b', 'ak', 'c'];
  @override
  Widget build(BuildContext context) {
    // sleep(const Duration(milliseconds: 2000));
    // print('inside build $adminval');
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
              title: Text('ADD NEWS'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Newinput()),
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
              // if (adminval == true) ...[
              //   ListTile(
              //     title: Text('Admin'),
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => Admin()),
              //       ); // Handle settings press
              //     },
              //   ),
              // ],
              if (AuthService().user != null) ...[
                FutureBuilder<bool>(
                    future: FirestoreService().checkadmin(AuthService().user?.email),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data == true && AuthService().user?.email!=null) {
                        print(AuthService().user);
                        print("Admin");
                        print(AuthService().user?.email);
                        return ListTile(
                          title: Text('Admin'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Admin()),
                            );
                          },
                        );
                      } else {
                        print("not Admin");
                        print(AuthService().user?.email);
                        return Container();
                      }
                    }
                )],
              ListTile(
                title: Text('Add Enitties'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddEntityScreen()),
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
                  TextField(
                    controller: data1,
                  ),
                  TextField(
                    controller: data2,
                  ),
                  TextField(
                    controller: data3,
                  ),
                  // ElevatedButton(
                  //   style: lalpiwla,
                  //   onPressed: () async {
                  //     await FirestoreService().createStudent(
                  //         dept: data1.text,
                  //         email: data2.text,
                  //         grad_yr: data3.text);
                  //   },
                  //   child: Text(
                  //     'Submits',
                  //     style: robo,
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: lalpiwla,
                        onPressed: () async {
                          await FirestoreService().createStudent(
                              dept: data1.text,
                              email: data2.text,
                              grad_yr: data3.text);
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MailList(
                                              buttonTexts: {
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
                              child: Text(
                                'Email',
                                style: robo,
                              )),
                          //   ElevatedButton(
                          //       style: lalpiwla,
                          //       onPressed: () async {
                          //         thing = await (FirestoreService()
                          //             .getUsersByEmail(
                          //                 "cse210001027@iiti.ac.in"));
                          //         print(thing?.ID);
                          //       },
                          //       child: Text(
                          //         'PSQF',
                          //         style: robo,
                          //       )),
                        ],
                      ),

                      // News(),
                      // ListView(
                      //   shrinkWrap: true,
                      //   children: [News()],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
    // Future.delayed(Duration.zero, () {
    //   FirestoreService().createUser(
    //       AuthService().user?.email, AuthService().user?.displayName, context);
    // });
    // return CircularProgressIndicator();
  } //build
}

// class SearchBar extends SearchDelegate {
//   final List<String> queryResult;

//   SearchBar(this.queryResult);

//   @override
//   //manipulation of tags should be done from here
//   //remember if query's last character is # then listen for the next whitespace and add the tag into search list
//   //also make a tag results column too
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final results =
//         queryResult.where((item) => item.startsWith(query)).toList();

//     if (results.isEmpty) {
//       return const Center(
//         child: Text(
//           'No results found.',
//           style: TextStyle(fontSize: 24),
//         ),
//       );
//     } else {
//       return ListView.builder(
//         itemCount: results.length,
//         itemBuilder: (BuildContext context, int index) {
//           final result = results[index];
//           return ListTile(
//             title: Text(result),
//             onTap: () {
//               // Handle result selection
//             },
//           );
//         },
//       );
//     }
//   }

//   @override
//   //optionally wrapping in a futurebuilder to listen to streams
//   Widget buildSuggestions(BuildContext context) {
//     final suggestionList = query.isEmpty
//         ? []
//         : queryResult.where((item) => item.startsWith(query)).toList();

//     return ListView.builder(
//       itemBuilder: (context, index) => ListTile(
//         //here you can change what happens when someone clicks on an object rendered by query
//         //TODO : on encountering a # await a whitespace to add to the list of tags with which we fetch a list of projects
//         onTap: () {
//           query = suggestionList[index];
//           showResults(context);
//         },
//         title: Text(suggestionList[index]),
//       ),
//       itemCount: suggestionList.length,
//     );
//   }
// }

