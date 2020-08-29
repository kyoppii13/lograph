import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lograph/screens/log_list/log_list_model.dart';
import 'package:lograph/screens/category_list.dart';
import 'package:lograph/screens/log_input.dart';
import 'package:lograph/screens/category_input.dart';
import 'package:lograph/screens/user_profile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lograph/common/list_item.dart';
import 'package:provider/provider.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class LogList extends StatefulWidget {
  static const String id = 'log_list';
  final String title = 'ログ一覧';
  @override
  _LogListState createState() => _LogListState();
}

class _LogListState extends State<LogList> {
  final _auth = FirebaseAuth.instance;
  bool _isVisibleFloatingActionButton = true;
  FloatingActionButton floatingActionButton;

  String _title = 'ログ一覧';
  Widget _appBarAction;
  List<Widget> currentTab = [
    LogListBody(),
    CategoryList(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LogListModel>(
      create: (_) => LogListModel()..fetchLogs(),
      child: Consumer<LogListModel>(builder: (context, model, child) {
        return Scaffold(
          body: currentTab[model.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: model.currentIndex,
            onTap: (index) {
              model.currentIndex = index;
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.formatListBulleted),
                title: Text('ログ一覧'),
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.chartLine),
                title: Text('グラフ一覧'),
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.account),
                title: Text('プロフィール'),
              ),
            ],
          ),
          floatingActionButton: Visibility(
            visible: model.isVisibleButton,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {},
            ),
          ),
        );
      }),
    );
  }
}

class LogListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetLogs(),
    );
  }
}

class GetLogs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LogListModel>(context);
    final listItems = provider.logs
        .map((log) => ListItem(
            date: DateTime.now(),
            value: log.value,
            category: '体重',
            icon: Icon(
              MdiIcons.armFlexOutline,
              size: 36,
            )))
        .toList();
    return Container(
      child: ListView(
        children: listItems,
      ),
    );
  }
}
