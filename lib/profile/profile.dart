import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/login/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firstapp/services/gmail.dart';

class ProfileScreen extends StatelessWidget {
  final data1 = TextEditingController();
  final data2 = TextEditingController();
  final data3 = TextEditingController();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Hello ${AuthService().user?.displayName}'),
        title: SearchBar(),
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
        ),
        ElevatedButton(
            onPressed: () => mailStreamliner()
                .PrintMessages('in:inbox subject:night AND subject:canteen'),
            child: const Text('print msges'))
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

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (query) {
        setState(() {
          _searchQuery = query;
        });
        // Call function to fetch search results using _searchQuery
      },
    );
  }
}
