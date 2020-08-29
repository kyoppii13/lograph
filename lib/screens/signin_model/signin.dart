import 'package:flutter/material.dart';
import 'package:lograph/screens/signin_model/signin_model.dart';
import 'package:lograph/screens/log_list/log_list_model.dart';
import 'package:lograph/screens/log_list/log_list.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:lograph/common/constants.dart';
import 'package:lograph/common/rounded_button.dart';
import 'package:provider/provider.dart';

class Signin extends StatelessWidget {
  static const String id = 'signin';
  final String title = 'ログイン';
  String email;
  String password;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SigninModel>(
      create: (_) => SigninModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
          backgroundColor: Colors.blue,
        ),
        body: Consumer<SigninModel>(builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.isShowSpinner,
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
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          validator: emailValidator,
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'メールアドレスを入力してください'),
                        ),
                        SizedBox(
                          height: 8,
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
                        )
                      ],
                    ),
                  ),
                  RoundedButton(
                    title: 'ログイン',
                    color: Colors.blueAccent,
                    onPressed: () async {
                      model.email = email;
                      model.password = password;

                      if (this._registerFormKey.currentState.validate()) {
                        try {
                          model.isShowSpinner = true;
                          final user = await model.signin();
                          print(user);
                          if (user != null) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute<void>(
                                builder: (context) =>
                                    ChangeNotifierProvider<LogListModel>(
                                  create: (_) => LogListModel(),
                                  child: Consumer<LogListModel>(
                                    builder: (context, model, child) {
                                      return LogList();
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                          model.isShowSpinner = false;
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
