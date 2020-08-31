import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lograph/screens/category_list.dart';
import 'package:lograph/screens/log_input.dart';
import 'package:lograph/screens/user_profile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lograph/widgets/list_item.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;

class LogList extends StatefulWidget {
  static const String id = 'log_list';

  @override
  _LogListState createState() => _LogListState();
}

class _LogListState extends State<LogList> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  String _title = 'ログ一覧';
  static List<Widget> _screenList = [
    LogTile(),
    CategoryList(),
    UserProfile(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        visible: _selectedIndex != 2,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<LogInput>(
                  builder: (context) {
                    return LogInput();
                  },
                  fullscreenDialog: true),
            );
          },
        ),
      ),
    );
  }
}

class LogTile extends StatefulWidget {
  @override
  _LogTileState createState() => _LogTileState();
}

class _LogTileState extends State<LogTile> {
  Future getLogs() async {
    final currentUser = await _auth.currentUser();
    QuerySnapshot logsQuery = await _firestore
        .collection('users')
        .document(currentUser.uid)
        .collection('logs')
        .getDocuments();
    return logsQuery.documents;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> category;
    @override
    void initState() {
      super.initState();
    }

    return SafeArea(
      child: FutureBuilder<dynamic>(
        future: getLogs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                final log = snapshot.data[index].data;

                return ListItem(
                  date: log['createdAt'].toDate(),
                  value: log['value'].toString(),
                  category: log['category']['name'].toString(),
                  unit: log['category']['unit'].toString(),
                  // icon: Icon(
                  //   MdiIcons.armFlexOutline,
                  //   size: 36,
                  // ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
