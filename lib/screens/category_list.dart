import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lograph/common/graph_item.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class CategoryList extends StatefulWidget {
  static const String id = 'category_list';
  final String title = 'グラフ一覧';
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: GetLogs(),
      ),
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
              if (index < 2) {
                return GraphItem(
                  date: DateTime.now(),
                  value: '50kg',
                  category: '体重',
                  icon: Icon(
                    MdiIcons.armFlex,
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
