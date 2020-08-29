import 'package:flutter/material.dart';

class UserProfileModel extends ChangeNotifier {
  String text = 'setting';

  void changeSettig() {
    text = 'setting kakikaeta';
    notifyListeners();
  }
}
