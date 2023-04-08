import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  final data1 = TextEditingController();
  final data2 = TextEditingController();
  final data3 = TextEditingController();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // title: 'FInallly',
      appBar: AppBar(
        title: Text('Hello ${AuthService().user?.displayName}'),
      ),
      body: Column(children: [
        LoginButton(
          text: 'sign out',
          color: Colors.black45,
          icon: FontAwesomeIcons.doorOpen,
          loginMethod: AuthService().signOut,
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
          onPressed: () async {
            await createUser(
                dept: data1.text, email: data2.text, grad_yr: data3.text);
          },
          child: const Text('submit'),
        )
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
