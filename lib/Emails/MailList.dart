import 'package:firstapp/Emails/MessageList.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firstapp/services/gmail.dart';

class MailList extends StatefulWidget {
  final Map<String, List<String>> buttonTexts;

  MailList({required this.buttonTexts});

  @override
  _MailListState createState() => _MailListState();
}

class _MailListState extends State<MailList> {
  bool _isLoading = false;

  Future<void> _getMessages(String query) async {
    setState(() {
      _isLoading = true;
    });

    final messages = await mailStreamliner().PrintMessages(query);

    setState(() {
      _isLoading = false;
    });

    if (messages.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MessageList(messages: messages),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Labels')),
      body: Column(
        children: [
          for (var entry in widget.buttonTexts.entries)
            Center(
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        // backgroundColor: Color.fromARGB(0, 255, 255, 255),
                        // shape: ContinuousRectangleBorder()
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15.0),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      onPressed: () => _getMessages(entry.key),
                      child: Text(entry.key),
                    ),
                  ),
                ),
              ),
            ),
          if (_isLoading) CircularProgressIndicator(),
        ],
      ),
    );
  }
}
