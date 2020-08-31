import 'package:flutter/material.dart';
import 'package:lograph/screens/log_detail.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  ListItem({this.date, this.value, this.category, this.icon, this.unit});

  final DateTime date;
  final String value;
  final String category;
  final Icon icon;
  final String unit;
  @override
  Widget build(BuildContext context) {
    var formatter = DateFormat('y/MM/dd HH:mm');
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: ListTile(
        title: Text(formatter.format(date)),
        subtitle: Text(
          '$category $value $unit',
          style: TextStyle(fontSize: 18),
        ),
        leading: icon,
        trailing:
            FittedBox(fit: BoxFit.fill, child: Icon(Icons.arrow_forward_ios)),
        onTap: () => {Navigator.pushNamed(context, LogDetail.id)},
      ),
    );
  }
}
