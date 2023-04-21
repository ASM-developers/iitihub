import 'package:firstapp/services/firestore.dart';
import 'package:firstapp/services/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/services/models.dart';
import 'package:firstapp/prof/details.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  TextEditingController searchtext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Projects"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: searchtext,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "search project",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: searchProject,
              ),
            ),
            Flexible(
              child: StreamBuilder<List<Projects>>(
                stream: FirestoreService().readProjects(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("something is wrong");
                  } else if (snapshot.hasData) {
                    final projects = snapshot.data;
                    return ListView(
                      children: projects!.map(buildProject).toList(),
                    );
                  } else {
                    return Text("empty");
                  }
                },
              ),
            ),
          ],
        ));
  }

  Widget buildProject(Projects projects) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          // leading: (Icon(Icons.person_pin_circle_sharp)),
          title: Text(projects.name),
          subtitle: Text(projects.prof),
          trailing: (Icon(Icons.menu)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: Color.fromRGBO(228, 228, 247, 0.494),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(project: projects),
                ));
          },
        ),
      );

  void searchProject(String query) {}
}
