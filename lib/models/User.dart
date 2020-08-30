import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String uid;

  User(this.email, this.uid);
}
