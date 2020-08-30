import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  IconTextButton({this.title, this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            this.icon,
            size: 35,
          ),
          Text(
            this.title,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
