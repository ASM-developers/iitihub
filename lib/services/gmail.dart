import 'package:firstapp/services/models.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:firstapp/services/auth.dart';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;
import 'package:googleapis_auth/auth_io.dart';

import 'dart:convert';

class mailStreamliner {
  final List<String> labels = [];

  //labels can be appended using addLabel function
  void addLabel({required String newLabel}) {
    labels.add(newLabel);
  }

  //labels can be removed using removeLabel
  void removeLabel({required String label}) {
    labels.remove(label);
  }

  //we need a function that returns all the messages requested under each label: will be called getUserMails
  //getUserMails will be the endpoint of this API that will be used to return a bunch of Mails

  Future<List<gmail.Message>> printWatchQuery(List<String> searchStrings) {
    // Construct a query string that watches for new messages containing any of the search strings
    String query = "in:inbox ";

    if (searchStrings != null && searchStrings.isNotEmpty) {
      query += "(";
      query += searchStrings.map((s) => "subject:${s}").join(" OR ");
      query += ") ";
    }
    // query += "category:primary";
    print('query final $query');

    // Return the query string
    return PrintMessages(query);
  }

  Future<List<gmail.Message>> PrintMessages(String? query) async {
    //gets the current client authenticated from auth service
    final client = (await AuthService().httpClient());
    //TODO: need to requestscopes locally for implementing incremental authorization

    //checks if the user is anonymously logged in or not
    if (client != null) {
      final gmail.GmailApi? gmailAPI = gmail.GmailApi(client);
      final response =
          await gmailAPI!.users.messages.list('me', q: query, maxResults: 3);

      final messages = response.messages;
      List<gmail.Message> messageList = [];
      for (final message in messages ?? []) {
        final fullMessage =
            await gmailAPI.users.messages.get('me', message.id!);
        messageList.add(fullMessage);
      }

      if (messages == null) {
        print('no results found');
      }

      return messageList;
    } else {
      print('something went wrong');
      return [];
    }
  }
}

//labels can be displayed by mapping mailStreamliner.labels so you don't need a function for that
