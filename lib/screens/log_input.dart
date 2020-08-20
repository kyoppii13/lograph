import 'package:flutter/material.dart';

class LogInput extends StatefulWidget {
  static const String id = 'log_input';
  final String title = 'ログ新規登録';
  @override
  _LogInputState createState() => _LogInputState();
}

class _LogInputState extends State<LogInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: Text('aaaa'),
    );
  }
}
