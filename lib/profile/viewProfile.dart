import 'package:firstapp/services/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class viewProfile extends StatefulWidget {
  final User user;

  const viewProfile({Key? key, required this.user}) : super(key: key);

  @override
  _viewProfileState createState() => _viewProfileState();
}

class _viewProfileState extends State<viewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name),
        ),
        body: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50, // Adjust the radius as needed
                  backgroundImage: AssetImage('assets/images/download.png'),
                ),
                Wrap(
                  spacing: 8.0, // horizontal gap between chips
                  runSpacing: 4.0, // vertical gap between lines of chips
                  children: widget.user.tags
                      .map((tag) => Chip(label: Text(tag)))
                      .toList(),
                )
              ],
            )
          ],
        ));
  }
}
