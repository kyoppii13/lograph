import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  IconTextButton({this.title, this.icon, this.onPressed});
  final String title;
  final IconData icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
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
