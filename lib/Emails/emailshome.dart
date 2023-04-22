import 'package:firstapp/services/gmail.dart';

import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;

class InboxWidget extends StatefulWidget {
  final Map<String, List<gmail.Message>> messagesMap;

  InboxWidget({ required this.messagesMap});

  @override
  _InboxWidgetState createState() => _InboxWidgetState();
}

class _InboxWidgetState extends State<InboxWidget> {
  Map<String, bool> _isExpandedMap = {};

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.messagesMap.length,
      itemBuilder: (BuildContext context, int index) {
        String heading = widget.messagesMap.keys.elementAt(index);
        List<gmail.Message>? messages = widget.messagesMap[heading];
        return ExpansionTile(
          title: Text(
            heading,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          initiallyExpanded: _isExpandedMap[heading] ?? false,
          onExpansionChanged: (bool isExpanded) {
            setState(() {
              _isExpandedMap[heading] = isExpanded;
            });
          },
          // children: messages.map((message) {
          //   return ListTile(
          //     title: Text(
          //       message.payload.headers
          //           .firstWhere((header) => header.name == "Subject")
          //           .value,
          //       maxLines: 1,
          //       overflow: TextOverflow.ellipsis,
          //     ),
          //     onTap: () {
          //       showDialog(
          //         context: context,
          //         builder: (BuildContext context) {
          //           return AlertDialog(
          //             title: Text(
          //               message.payload.headers
          //                   .firstWhere((header) => header.name == "Subject")
          //                   .value,
          //             ),
          //             content: SingleChildScrollView(
          //               child: Text(_extractMessageBody(message)),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   );
          // }).toList(),
        );
      },
    );
  }

  String? _extractMessageBody(gmail.Message message) {
    List<gmail.MessagePart>? parts = message.payload?.parts;
    if (parts == null) {

      return message.payload?.body?.data;
    } else {
      for (gmail.MessagePart part in parts ??[] ) {
        if (part.mimeType == "text/plain") {
          return part.body?.data;
        }
      }
    }
    return "";
  }
}