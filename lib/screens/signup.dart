import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lograph/widgets/constants.dart';
import 'package:lograph/widgets/rounded_button.dart';
import 'package:lograph/screens/log_list.dart';
import 'package:lograph/screens/signin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Signup extends StatefulWidget {
  static const String id = 'signup';
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  final _store = Firestore.instance;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  bool isShowSpinner = true;
  String email;
  String password;

  @override
  initState() {
    _auth
        .currentUser()
        .then((currentUser) => {
              if (currentUser == null)
                {
                  setState(() {
                    isShowSpinner = false;
                  })
                }
              else
                {
                  _store
                      .collection('users')
                      .document(currentUser.uid)
                      .get()
                      .then((DocumentSnapshot result) => {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogList())),
                            setState(() {
                              isShowSpinner = false;
                            })
                          })
                      .catchError(
                        (error) => print(error),
                      )
                }
            })
        .catchError(
          (error) => print(error),
        );
    super.initState();
  }

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
                  height: 8,
                ),
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: emailValidator,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'メールアドレスを入力してください'),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                        },
                        validator: passwordValidator,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'パスワードを入力してください'),
                      ),
                    ],
                  ),
                ),
                RoundedButton(
                  title: '新規登録',
                  color: Colors.blueAccent,
                  onPressed: () async {
                    if (this._registerFormKey.currentState.validate()) {
                      setState(() {
                        isShowSpinner = true;
                      });
                      await _auth
                          .createUserWithEmailAndPassword(
                              email: email, password: password)
                          .then((AuthResult currentUser) => _store
                              .collection("users")
                              .document(currentUser.user.uid)
                              .setData({
                                "uid": currentUser.user.uid,
                                "email": email,
                                "imageUrl": '',
                                "createdAt": Timestamp.now(),
                              })
                              .then((result) => {
                                    Navigator.pushReplacementNamed(
                                        context, LogList.id),
                                    setState(() {
                                      isShowSpinner = false;
                                    })
                                  })
                              .catchError((error) => print(error)))
                          .catchError((error) => print(error));
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
