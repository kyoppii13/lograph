import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  static const String id = 'user_info';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('UserInfo'),
    );
  }
}
