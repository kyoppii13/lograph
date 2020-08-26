import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lograph/screens/log.dart';

class LogListModel with ChangeNotifier {
  List<Log> logs = [];
  int _currentIndex = 1;
  DocumentSnapshot currentUser;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future fetchLogs() async {
    final documents =
        await Firestore.instance.collection('logs').getDocuments();
    final logs =
        documents.documents.map((document) => Log(document['value'])).toList();
    this.logs = logs;
    notifyListeners();
  }
}
