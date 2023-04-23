// Map< String , List<String>> messages =  {
//   'TECH' : [ 'Cynaptics', 'Robotics', 'IVDC' , 'PClub' , 'GDSC'],
//   'CULT' : [ 'Kalakriti', 'Aaina', 'debsoc' , 'literary' , 'dance', 'music'],
//   'CERP' : [ 'CERP'],
//   'SPORTS' : ['Swimming', 'Table', 'Tennis', 'Cricket' ],
//   'Dinning' : ['Mess', 'Food', 'Kanaka', 'Ajay'],
//   'Hostel' : ['Room','Hostel',]
// };

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;

class MessageDetails extends StatelessWidget {
  final gmail.Message message;

  MessageDetails({required this.message});

  @override
  Widget build(BuildContext context) {
    final headers = message.payload?.headers;

    final fromHeader =
        headers?.firstWhere((header) => header.name == 'From').value;

    final toHeader = headers?.firstWhere((header) => header.name == 'To').value;

    final subjectHeader =
        headers?.firstWhere((header) => header.name == 'Subject').value;

    final body = message.payload?.parts?[0].body?.data;

    final decodedBody = utf8.decode(base64.decode(body ?? ""));

    return Scaffold(
      appBar: AppBar(
        title: Text(subjectHeader ?? "null"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'From: $fromHeader',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8.0),
              Text(
                'To: $toHeader',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              Text(
                decodedBody,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
