import 'package:flutter/material.dart';
import 'package:lograph/screens/signin.dart';
import 'package:lograph/screens/signup.dart';
import 'package:lograph/screens/category_list.dart';

void main() => runApp(Lograph());

class Lograph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Signup.id,
      routes: {
        Signin.id: (context) => Signin(),
        Signup.id: (context) => Signup(),
        CategoryList.id: (context) => CategoryList(),
      },
    );
  }
}
