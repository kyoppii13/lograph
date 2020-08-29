import 'package:flutter/material.dart';
import 'package:lograph/screens/log_list/log_list_model.dart';
import 'package:lograph/screens/category_input.dart';
import 'package:lograph/screens/log_detail.dart';
import 'package:lograph/screens/log_input.dart';
import 'package:lograph/screens/signin_model/signin.dart';
import 'package:lograph/screens/signup/signup.dart';
import 'package:lograph/screens/category_list.dart';
import 'package:lograph/screens/category_detail.dart';
import 'package:lograph/screens/log_list/log_list.dart';
import 'package:lograph/screens/user_profile.dart';
import 'package:lograph/screens/setting.dart';

void main() => runApp(Lograph());

class Lograph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Signup(),
      routes: {
        Signin.id: (context) => Signin(),
        Signup.id: (context) => Signup(),
        CategoryList.id: (context) => CategoryList(),
        LogList.id: (context) => LogList(),
        UserProfile.id: (context) => UserProfile(),
        CategoryInput.id: (context) => CategoryInput(),
        LogInput.id: (context) => LogInput(),
        LogDetail.id: (context) => LogDetail(),
        CategoryDetail.id: (context) => CategoryDetail(),
        Setting.id: (context) => Setting(),
      },
    );
  }
}
