import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/services/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firstapp/services/firestore.dart';

class viewProfile extends StatefulWidget {
  final User user;

  const viewProfile({Key? key, required this.user}) : super(key: key);

  @override
  _viewProfileState createState() => _viewProfileState();
}

class _viewProfileState extends State<viewProfile> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  var db = FirebaseFirestore.instance;
  var b = AuthService().user?.photoURL.toString();
  String spp = 'Show profile Picture';
  String hpp = 'Hide profile Picture';

  final refreal = FirebaseDatabase.instance.ref();

  void setImag() async {
    User thing = await (FirestoreService().getUsersByEmail(widget.user.email));
    print(thing?.ID);
    final docRef = thing?.ID;
    print(docRef);
    final a = await ref.child('${docRef}/photoURL').get();
    if (a.value == null) {}
    print('mad');
    print(a.value.toString());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      body: Column(
        children: [
          Column(
            children: [
              ClipOval(
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
                          color: Colors.black45,
                          elevation: 10,
                          child: TextButton(
                            onPressed: () {
                              if (spp == 'Show profile Picture') {
                                setImag();
                              } else {
                                setImag2();
                              }
                            },
                            child: Text(
                              spp,
                              style: TextStyle(
                                color: Colors.orange.shade200,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Wrap(
                        spacing: 8.0, // horizontal gap between chips
                        runSpacing: 4.0, // vertical gap between lines of chips
                        children: widget.user.tags
                            .map((tag) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Chip(label: Text(tag)),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
