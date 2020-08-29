import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
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

  Future signUp() async {
    final result = await (_auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ));
    final store =
        await _store.collection("users").document(result.user.uid).setData({
      "uid": result.user.uid,
      "email": email,
    });
    return store;
    // .then(
    //   (AuthResult currentUser) =>
    //       _store.collection("users").document(currentUser.user.uid).setData(
    //     {
    //       "uid": currentUser.user.uid,
    //       "email": email,
    //     },
    //   ).catchError((error) {
    //     print(error);
    //   }),
    // );
  }
}
