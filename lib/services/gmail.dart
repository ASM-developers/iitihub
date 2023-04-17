import 'package:firstapp/services/models.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:firstapp/services/auth.dart';

class mailStreamliner {
  // AuthService().User
  //need some variable properties

  final List<String> labels = [];
  var gmailAPI = gmail.GmailApi;

  //labels can be appended using addLabel function
  void addLabel({required String newLabel}) {
    labels.add(newLabel);
  }

  //labels can be removed using removeLabel
  void removeLabel({required String label}) {
    labels.remove(label);
  }

  //labels can be displayed by mapping mailStreamliner.labels so you don't need a function for that
}
