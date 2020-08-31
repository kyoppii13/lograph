import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lograph/screens/log_list.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:lograph/widgets/constants.dart';
import 'package:lograph/widgets/rounded_button.dart';
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
  bool isShowValidationMessage = false;
  String email;
  String password;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

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
              Form(
                key: _registerFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        email = value;
                      },
                      validator: emailValidator,
                      style: TextStyle(fontSize: 14),
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'メールアドレス'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        password = value;
                      },
                      validator: passwordValidator,
                      style: TextStyle(fontSize: 14),
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'パスワード'),
                    ),
                    Visibility(
                      visible: isShowValidationMessage,
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          child: Text('メールアドレスまたはパスワードが間違っています',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Color(0xffd32f2f))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RoundedButton(
                title: 'ログイン',
                color: Colors.blueAccent,
                onPressed: () async {
                  if (this._registerFormKey.currentState.validate()) {
                    setState(() {
                      isShowSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LogList()),
                          (_) => false,
                        );
                      }
                      setState(() {
                        isShowSpinner = false;
                      });
                    } catch (error) {
                      if (error is PlatformException &&
                          error.code == 'ERROR_USER_NOT_FOUND') {
                        setState(() {
                          isShowValidationMessage = true;
                          isShowSpinner = false;
                        });
                      }
                    }
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
