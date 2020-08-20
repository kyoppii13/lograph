import 'package:flutter/material.dart';

class CategoryInput extends StatefulWidget {
  static const String id = 'category_input';
  final String title = 'カテゴリー新規登録';
  @override
  _CategoryInputState createState() => _CategoryInputState();
}

class _CategoryInputState extends State<CategoryInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: Text('CategoryInput'),
    );
  }
}
