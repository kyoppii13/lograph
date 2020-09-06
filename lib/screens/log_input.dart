import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lograph/widgets/constants.dart';
import 'package:lograph/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;

class LogInput extends StatefulWidget {
  static const String id = 'log_input';
  final String title = 'ログ新規登録';
  @override
  _LogInputState createState() => _LogInputState();
}

class _LogInputState extends State<LogInput> {
  DateTime _datetime = DateTime.now();
  DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');
  FirebaseUser _currentUser;
  final _store = Firestore.instance;
  bool isShowSpinner = false;

  Future uploadLog() async {
    final currentUser = await _auth.currentUser();
    await _store
        .collection('users')
        .document(currentUser.uid)
        .collection('logs')
        .add({"value": 100});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isShowSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            child: Column(
              children: [
                DropdownButtonFormField(
                  items: ['体重', '身長']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: '値'),
                      ),
                    ),
                    Text(
                      '単位',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  formatter.format(_datetime),
                  style: TextStyle(fontSize: 18),
                ),
                RoundedButton(
                  title: '登録',
                  color: Colors.blueAccent,
                  onPressed: () async {
                    try {
                      setState(() {
                        isShowSpinner = true;
                      });
                      await uploadLog();
                      setState(() {
                        isShowSpinner = false;
                      });
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('登録完了'),
                              actions: [
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            );
                          });
                      Navigator.pop(context);
                    } catch (error) {
                      return AlertDialog(
                        title: Text(error.toString()),
                        actions: [
                          FlatButton(
                            child: Text('Error'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
