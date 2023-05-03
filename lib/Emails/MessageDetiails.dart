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
              Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(153, 153, 153, 1),
                    borderRadius: BorderRadius.all(Radius.circular(
                            5.0) //                 <--- border radius here
                        ),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(children: [
                          Text("From:   ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                  fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(
                              '$fromHeader',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(12, 12, 12, 1),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(height: 6.0),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(children: [
                          Text("To:   ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                  fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(
                              '$toHeader',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(12, 12, 12, 1),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  )),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(12, 12, 12, 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(
                          5.0) //                 <--- border radius here
                      ),
                ),
                child: Text(
                  decodedBody,
                  style: TextStyle(fontSize: 16, color: Color.fromRGBO(148, 147, 147, 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
