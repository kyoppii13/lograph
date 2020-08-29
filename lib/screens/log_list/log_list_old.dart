import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lograph/screens/category_list.dart';
import 'package:lograph/screens/log_input.dart';
import 'package:lograph/screens/category_input.dart';
import 'package:lograph/screens/user_profile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lograph/common/list_item.dart';

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

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  int _selectedIndex = 1;
  String _title = 'ログ一覧';
  Widget _appBarAction;
  static List<Widget> _screenList = [
    LogListBody(),
    CategoryList(),
    UserProfile(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          {
            _isVisibleFloatingActionButton = true;
            _appBarAction = LogInput();
          }
          break;
        case 1:
          {
            _isVisibleFloatingActionButton = true;
            _appBarAction = CategoryInput();
          }
          break;
        case 2:
          {
            _isVisibleFloatingActionButton = false;
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: Visibility(
        visible: _isVisibleFloatingActionButton,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) {
                    return _appBarAction;
                  },
                  fullscreenDialog: true),
            );
          },
        ),
      ),
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
    return FutureBuilder(
      future: _firestore.collection('logs').document('Test').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemBuilder: (BuildContext context, int index) {
              if (index < 10) {
                return ListItem(
                  date: DateTime.now(),
                  value: '50kg',
                  category: '体重',
                  icon: Icon(
                    MdiIcons.armFlexOutline,
                    size: 36,
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
