import 'package:flutter/material.dart';
import 'package:lograph/models/User.dart';
import 'package:lograph/widgets/rounded_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Setting extends StatefulWidget {
  Setting(this.user);
  User user;

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('設定')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Stack(children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.imageUrl),
                    backgroundColor: Colors.transparent,
                    radius: 40,
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0x22000000),
                    child: Icon(
                      Icons.add_a_photo,
                      color: Color(0xDDFFFFFF),
                      size: 32,
                    ),
                    radius: 40,
                  )
                ]),
              ),
              RoundedButton(
                  title: '保存', color: Colors.blueAccent, onPressed: () async {})
            ],
          ),
        ));
  }
}
