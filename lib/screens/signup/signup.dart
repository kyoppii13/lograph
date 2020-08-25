import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lograph/common/constants.dart';
import 'package:lograph/common/rounded_button.dart';
import 'package:lograph/screens/log_list.dart';
import 'package:lograph/screens/signin.dart';
import 'package:lograph/screens/signup/signup_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:lograph/screens/log_list_model.dart';

// class Signup extends StatefulWidget {
//   static const String id = 'signup';
//   @override
//   _SignupState createState() => _SignupState();
// }

class Signup extends StatelessWidget {
  // final _auth = FirebaseAuth.instance;
  // final _store = Firestore.instance;
  static const String id = 'signup';
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  bool isShowSpinner = false;
  String email;
  String password;

  // @override
  // initState() {
  //   _auth
  //       .currentUser()
  //       .then((currentUser) => {
  //             if (currentUser == null)
  //               {
  //                 setState(() {
  //                   isShowSpinner = false;
  //                 })
  //               }
  //             else
  //               {
  //                 _store
  //                     .collection('users')
  //                     .document(currentUser.uid)
  //                     .get()
  //                     .then((DocumentSnapshot result) => {
  //                           Navigator.of(context).push(
  //                             MaterialPageRoute<void>(
  //                               builder: (context) =>
  //                                   ChangeNotifierProvider<LogListModel>(
  //                                 create: (_) => LogListModel(),
  //                                 child: Consumer<LogListModel>(
  //                                   builder: (context, model, child) {
  //                                     return LogList();
  //                                   },
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           setState(() {
  //                             isShowSpinner = false;
  //                           })
  //                         })
  //                     .catchError(
  //                       (error) => print(error),
  //                     )
  //               }
  //           })
  //       .catchError(
  //         (error) => print(error),
  //       );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<SignUpModel>(builder: (context, model, child) {
            return ModalProgressHUD(
              inAsyncCall: model.isShowSpinner,
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
                              model.email = value;
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
                              model.password = value;
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
                            model.isShowSpinner = true;
                            await model
                                .signUp()
                                .then((_) => {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute<void>(
                                          builder: (context) =>
                                              ChangeNotifierProvider<
                                                  LogListModel>(
                                            create: (_) => LogListModel(),
                                            child: Consumer<LogListModel>(
                                              builder: (context, model, child) {
                                                return LogList();
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      isShowSpinner = false,
                                    })
                                .catchError((error) {
                              print(error);
                            });
                          }
                        }),
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
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) {
                              return Signin();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }
}
