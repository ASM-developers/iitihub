import 'dart:convert';
import 'dart:core';
import 'dart:collection';
import 'package:firstapp/Emails/MessageDetiails.dart';
import 'package:firstapp/services/gmail.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;

class MessageList extends StatelessWidget {
  final List<gmail.Message> messages;

  MessageList({required this.messages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          final message = messages[index];
          // final subject = message.payload?.headers
          //     ?.firstWhere((header) => header.name == 'Subject')
          //     .value;
          final headers = message.payload?.headers;
          final subject =
              headers?.firstWhere((header) => header.name == 'Subject');
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageDetails(message: message),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: ListTile(
                title: Text(
                  _getSubjectSnippet(subject?.value ?? ""),
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${message.payload?.headers?.firstWhere((header) => header.name == 'From').value} - ${_getBodySnippet(message)}',
                  style: TextStyle(fontSize: 12.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: Color.fromRGBO(40, 40, 225, 0.49),
          leading: Icon(Icons.mail),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getBodySnippet(gmail.Message message) {
    if (message.payload?.parts != null) {
      final body = utf8.decode(
          base64.decode(message.payload?.parts?.first.body?.data ?? ""));
      return body.substring(0, body.indexOf('\n')).trim();
    } else {
      return utf8
          .decode(base64.decode(message.payload?.body?.data ?? ""))
          .trim();
    }
  }

  String _getSubjectSnippet(String subject) {
    if (subject.length > 30) {
      return '${subject.substring(0, 30)}...';
    } else {
      return subject;
    }
  }
}
