import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  CircleButton({this.icon, this.color, @required this.onPressed});

  final Color color;
  final Icon icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Material(
        elevation: 5,
        color: color,
        shape: CircleBorder(),
        child: IconButton(
          icon: icon,
          onPressed: onPressed,
          color: Colors.white,
        ),
      ),
    );
  }
}
