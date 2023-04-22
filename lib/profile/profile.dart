import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/prof/prof.dart';
import 'package:firstapp/prof/projects.dart';
import 'package:firstapp/services/firestore.dart';
import 'package:firstapp/services/models.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firstapp/services/gmail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/admin/admin.dart';
import 'package:firstapp/admin/add_entity.dart';

import 'package:get/get.dart';
import 'package:firstapp/tags/tagsInput.dart';
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


int adminval = 0 ;

Future<int> updateadminval() async {

  int valS = await  FirestoreService().checkadmin(AuthService().user?.email.toString(),) ;
  print('valS $valS');

  adminval = valS ; //= vals
  print('adminval $valS ');


  return valS ;
}

class _ProfileScreenState extends State<ProfileScreen>  {
  final data1 = TextEditingController();
  final data2 = TextEditingController();
  final data3 = TextEditingController();


  @override
 void initState()  {
    super.initState();
    int val = adminval ;
    // FirestoreService().createUser(
    //     AuthService().user?.email, AuthService().user?.displayName, context);
    // print("inside initstate before update adminval $val");
    // // await updateadminval();
    //
    // print("inside initstate after update adminval $val");

  }



  //stores the value of current user can be accessed using a constructor

  List<Student>? thing;

  //here lies the constructor which should be called upon clicking signin

  //sample queryResult thing to be fetched from the backend
  final queryResult = ['a', 'b', 'ak', 'c'];
  @override
  Widget build(BuildContext context) {

    FirestoreService().createUser(
          AuthService().user?.email, AuthService().user?.displayName, context);
    // sleep(const Duration(milliseconds: 2000));
    // print('inside build $adminval');
    updateadminval();
    // sleep(const Duration(milliseconds: 5000));
    // print('just before scaffold $adminval');

    return Scaffold(

      resizeToAvoidBottomInset : false,
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
        child: ListView (
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Hi'),
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

            if ( adminval == 1) ...[
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
            ListTile(
              title: Text('Add Enitties'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddEntityScreen()),
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
            await FirestoreService().createStudent(
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
    // Future.delayed(Duration.zero, () {
    //   FirestoreService().createUser(
    //       AuthService().user?.email, AuthService().user?.displayName, context);
    // });
    // return CircularProgressIndicator();


  }//build
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

class CircularImage extends StatefulWidget {
  final String imageFile;
  final double size;
  CircularImage({Key? key, required this.imageFile, this.size = 100.0})
      : super(key: key);

  @override
  State<CircularImage> createState() => _CircularImageState();
}

class _CircularImageState extends State<CircularImage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  var b = AuthService().user?.photoURL.toString();
  String spp = 'Show profile Picture';
  String hpp = 'Hide profile Picture';
  void setImag() async {
    final a = await ref.child('${AuthService().user?.uid}/photoURL').get();
    if (a.value == null) {}
    print(a.value.toString());
    print('Thank You Madhav');
    setState(() {
      b = a.value.toString();
      String mad = spp;
      spp = hpp;
      hpp = mad;
    });
  }

  void setImag2() {
    setState(() {
      b = AuthService().user?.photoURL.toString();
      String mad = spp;
      spp = hpp;
      hpp = mad;
    });
  }

  final picker = ImagePicker();

  // final snapshot = FirebaseDatabase.instance
  //     .ref()
  //     .child('User/${AuthService().user?.uid}/photoURL')
  //     .get();
  XFile? _image;

  XFile? get image => _image;

  void uploadImage(BuildContext context) async {
    firebase_storage.Reference sRef = firebase_storage.FirebaseStorage.instance
        .ref('${AuthService().user?.uid}');
    firebase_storage.UploadTask uploadTask =
        sRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final newURL = await sRef.getDownloadURL();
    // print(snapshot.toString());

    print(newURL);
    setImag();
    setState(() {
      b = newURL.toString();
    });
    ref
        .child('${AuthService().user?.uid}')
        .update({'photoURL': b}).then((value) => _image = null);
    // print('${AuthService().user}');
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
    }
  }

  @override

  //when we are able to fetch image uri from backend replace the placeholder with Image.fronUri() and add the text obtained in imageFile
  Widget build(BuildContext context) {
    return ClipOval(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage('${b}'),
              radius: 55,
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Card(
                    child: TextButton(
                        onPressed: () {
                          if (spp == 'Show profile Picture') {
                            setImag();
                          } else {
                            setImag2();
                          }
                        },
                        child: Text(spp)))),
            Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.camera,
                  size: 30.0,
                ),
                onPressed: () {
                  print('${AuthService().user}');
                  pickGalleryImage(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
