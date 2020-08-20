import 'package:flutter/material.dart';
import 'package:lograph/screens/log_detail.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  ListItem({this.date, this.value, this.category, this.icon});

  final DateTime date;
  final String value;
  final String category;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    var formatter = DateFormat('y/MM/dd HH:mm:ss');
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(formatter.format(date)),
        subtitle: Text(
          '$category $value',
          style: TextStyle(fontSize: 18),
        ),
        leading: icon,
        trailing: Expanded(
          child:
              FittedBox(fit: BoxFit.fill, child: Icon(Icons.arrow_forward_ios)),
        ),
        onTap: () => {Navigator.pushNamed(context, LogDetail.id)},
      ),
    );
  }
}
