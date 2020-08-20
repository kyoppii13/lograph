import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lograph/screens/log_list.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:lograph/common/constants.dart';
import 'package:lograph/common/rounded_button.dart';
import 'package:lograph/screens/category_list.dart';
import 'package:lograph/screens/signup.dart';

class Signin extends StatefulWidget {
  static const String id = 'signin';
  final String title = 'ログイン';
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _auth = FirebaseAuth.instance;
  bool isShowSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: ModalProgressHUD(
        inAsyncCall: isShowSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                      height: 200, child: Image.asset('images/logo.png')),
                ),
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
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'パスワードを入力してください'),
                ),
              ),
              RoundedButton(
                title: 'ログイン',
                color: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    isShowSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.popUntil(
                          context, ModalRoute.withName(Signup.id));
                      Navigator.pushReplacementNamed(context, LogList.id);
                    }
                    setState(() {
                      isShowSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
