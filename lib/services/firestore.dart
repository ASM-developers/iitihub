import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/services/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<String>> getResults(String query) async {
    // replace this with your actual firestore collection path
    final CollectionReference collection = _db.collection('student');

    // query the collection for documents containing the query string
    QuerySnapshot snapshot = await collection
        .where('dept', isGreaterThanOrEqualTo: query)
        .where('dept', isLessThan: query + 'z')
        .get();

    // extract the data from the snapshot and return as a list of strings
    List<String> results =
        snapshot.docs.map((doc) => doc.get('dept') as String).toList();

    return results;
  }
}
