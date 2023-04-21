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

  Future<bool> checkadmin(String? email) async {
    final check = await FirebaseFirestore.instance
        .collection('admin')
        .where("email", isEqualTo: email)
        .get();

    if (check.size > 0) {
      print("hurrya");
      return true;
    }
    print("fuck off");
    return false;
  }

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

  Future createStudent({
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

  Future submitdata(
      {required String projname,
      required String projdes,
      required List<String> tags,
      required String date}) async {
    final docuser = FirebaseFirestore.instance.collection('Projects').doc();
    final json = {
      'ID': docuser.id,
      'date': date,
      'description': projdes,
      'name': projname,
      'prof': AuthService().user?.email.toString(),
      'tags': tags,
    };
    await docuser.set(json);
  }

  Stream<List<Projects>> readProjects() => FirebaseFirestore.instance
      .collection('prof')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((e) => Projects.fromJson(e.data())).toList());
}
