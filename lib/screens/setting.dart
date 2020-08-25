import 'package:flutter/material.dart';
import 'package:lograph/screens/setting_model.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  static const String id = 'setting';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingModel>(
      create: (_) => SettingModel(),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<SettingModel>(builder: (context, model, child) {
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  Container(
                    child: Text(model.text),
                  ),
                  RaisedButton(
                    child: Text('button'),
                    onPressed: () {
                      model.changeSettig();
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
