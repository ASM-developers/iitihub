import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/services/models.dart';

import '../tags/tagsInput.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //currently extracts students with a given dept name but can be done for name fetching
  //TODO : add a function that takes in a list of tags and pulls out a matching set of strings
  Future<List<Student>> getStudentsByDept(String query) async {
    List<Student> Students = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('student')
        .where('dept', isGreaterThanOrEqualTo: query)
        .where('dept', isLessThan: query + 'z')
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      Students.add(Student.fromJson(doc.data()));
    }

    return Students;
  }

  // void showMyModal(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('My Modal'),
  //         content: Text('This is my modal.'),
  //         actions: [
  //           TextButton(
  //             child: Text('Next'),
  //             onPressed: () async {
  //               await AuthService().googleLogin();
  //               //await function that will take in some text handling and give us the tags in those lists
  //               final List<String> tags = const [];
  //               User newUser = User(
  //                 email: (AuthService().user?.email)!,
  //                 name: (AuthService().user?.displayName)!,
  //                 tags: tags,
  //               );

  //               await FirestoreService().createUser(newUser);

  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> createUser(
      String? email, String? name, BuildContext context) async {
    final RegExp isStudent = RegExp(r'^[a-z]{2,4}\d{9}@iiti\.ac\.in$');
    User user = User(
      email: email ?? "",
      name: name ?? "",
    );

    if (isStudent.hasMatch(user.email)) {
      user.type = 'student';
    } else {
      user.type = 'professor';
    }
    //if this expression matches then its a student. Otherwise its a prof
    //use this regex query to decide wh
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      print('User already exists');
    } else {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                child: TagInput(
                  someone: user,
                  onSubmit: (tags) async {
                    // Do something with the tags
                    user.tags = tags;
                    await FirebaseFirestore.instance
                        .collection('users')
                        .add(user.toJson());

                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          );
        },
      ); //Note: for a particular insti we have to add another regexp isMember for testing purposes not added
    }
  }
}
