import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lograph/common/rounded_button.dart';
import 'package:lograph/common/icon_text_button.dart';
import 'package:lograph/screens/log_list_old.dart';
import 'package:lograph/screens/setting.dart';

class UserProfile extends StatefulWidget {
  static const String id = 'user_info';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _auth = FirebaseAuth.instance;
  final _store = Firestore.instance;
  String loggedInUser = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    _auth
        .currentUser()
        .then((currentUser) => {
              _store
                  .collection('users')
                  .document(currentUser.uid)
                  .get()
                  .then((DocumentSnapshot result) => {
                        setState(() {
                          loggedInUser = result.data['email'];
                        })
                      })
                  .catchError(
                    (error) => print(error),
                  )
            })
        .catchError(
          (error) => print(error),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: UserProfileCurveClipper(),
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF1dd5e6),
                  Color(0xFF0d47a1),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage('images/tatsuro_profile_image.jpg'),
                  backgroundColor: Colors.transparent,
                  radius: 40.0,
                ),
                SizedBox(height: 12),
                Text(
                  loggedInUser,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconTextButton(
                title: '設定',
                icon: Icons.settings,
                onPressed: () => {Navigator.pushNamed(context, Setting.id)},
              ),
              IconTextButton(title: 'ヘルプ', icon: Icons.help),
              IconTextButton(title: 'お問い合わせ', icon: Icons.mail),
            ],
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RoundedButton(
                title: 'ログアウト',
                color: Colors.redAccent,
                onPressed: () async {
                  // setState(() {
                  //   isShowSpinner = true;
                  // });
                  try {
                    // final user = await _auth.signInWithEmailAndPassword(
                    //     email: email, password: password);
                    // if (user != null) {
                    //   Navigator.popUntil(
                    //       context, ModalRoute.withName(Signup.id));
                    //   Navigator.pushReplacementNamed(context, LogList.id);
                    // }
                    setState(() {
                      // isShowSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UserProfileCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
