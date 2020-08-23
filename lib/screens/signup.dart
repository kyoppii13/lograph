import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lograph/common/circle_button.dart';
import 'package:lograph/common/constants.dart';
import 'package:lograph/common/rounded_button.dart';
import 'package:lograph/screens/category_list.dart';
import 'package:lograph/screens/signin.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Signup extends StatefulWidget {
  static const String id = 'signup';
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  bool isShowSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: isShowSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 150,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    Text(
                      'Lograph',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 42,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'メールアドレスを入力してください'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 42,
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'パスワードを入力してください'),
                  ),
                ),
                RoundedButton(
                  title: '新規登録',
                  color: Colors.blueAccent,
                  onPressed: () async {
                    setState(() {
                      isShowSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushReplacementNamed(
                            context, CategoryList.id);
                      }
                      setState(() {
                        isShowSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Divider(
                //         color: Colors.grey,
                //         height: 10,
                //       ),
                //     ),
                //     Text(
                //       '別サービスでログイン',
                //       style: TextStyle(
                //         color: Colors.grey,
                //       ),
                //     ),
                //     Expanded(
                //       child: Divider(
                //         color: Colors.grey,
                //         height: 10,
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     CircleButton(
                //       icon: Icon(MdiIcons.twitter),
                //       color: Color.fromRGBO(29, 161, 242, 1),
                //       onPressed: () {
                //       },
                //     ),
                //     CircleButton(
                //       icon: Icon(MdiIcons.facebook),
                //       color: Color.fromRGBO(59, 89, 152, 1),
                //       onPressed: () {},
                //     ),
                //     CircleButton(
                //       icon: Icon(MdiIcons.google),
                //       color: Color.fromRGBO(219, 68, 55, 1),
                //       onPressed: () {},
                //     )
                //   ],
                // ),
                RoundedButton(
                  title: 'ログイン',
                  color: Colors.blueGrey[200],
                  onPressed: () {
                    Navigator.pushNamed(context, Signin.id);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
