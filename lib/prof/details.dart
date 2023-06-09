import 'package:firstapp/prof/updateProject.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/services/firestore.dart';
import 'package:firstapp/services/models.dart';
import 'package:flutter/material.dart';

import 'my_projects.dart';

import 'package:linkwell/linkwell.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.project});

  final Projects project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Research project"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Wrap(
              children: project.tags
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Chip(
                          label: Text(e),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 15, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Project Name: \n${project.name}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Professor name: \n${project.prof}',
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Date: \n${project.date}',
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 15),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: LinkWell(
                'Description: \n${project.description}',
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
                textAlign: TextAlign.left,
                maxLines: null,
              ),
            ),
          ),
          if (project.prof == AuthService().user?.email) ...[
            ElevatedButton(
              onPressed: () {
                FirestoreService().deleteProject(project.ID);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProjectScreen()),
                );
              },
              child: Text('Delete Project'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => updateProject(
                            project: project,
                          )),
                );
              },
              child: Text('update Project'),
            ),
          ]
        ]),
      ),
    );
  }
}
