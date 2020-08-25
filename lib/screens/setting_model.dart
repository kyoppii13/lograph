import 'package:flutter/material.dart';

class SettingModel extends ChangeNotifier {
  String text = 'setting';

  void changeSettig() {
    text = 'setting kakikaeta';
    notifyListeners();
  }
}
