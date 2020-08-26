import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninModel extends ChangeNotifier {
  String email = '';
  String password = '';
  bool _isShowSpinner = false;
  bool get isShowSpinner => _isShowSpinner;
  set isShowSpinner(bool value) {
    _isShowSpinner = value;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _store = Firestore.instance;

  Future<FirebaseUser> signin() async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }
}
