import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lograph/models/User.dart';
import 'package:lograph/widgets/rounded_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Setting extends StatefulWidget {
  Setting(
    this.user,
    this.callback,
  );
  User user;
  Future<User> callback;

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  File _image;
  final picker = ImagePicker();
  final _store = Firestore.instance;
  final _storage = FirebaseStorage.instance;

  bool isShowSpinner = false;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future<String> _uploadImage(String uid) async {
    StorageTaskSnapshot snapshot =
        await _storage.ref().child("profiles/$uid").putFile(_image).onComplete;

    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future updateImage(String uid) async {
    final imageUrl = await _uploadImage(uid);
    await _store.collection('users').document(uid).updateData(
      {
        'imageUrl': imageUrl,
        'updatedAt': Timestamp.now(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isShowSpinner,
      child: Scaffold(
          appBar: AppBar(title: Text('設定')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await getImage();
                  },
                  child: Stack(children: [
                    CircleAvatar(
                      backgroundImage: _image != null
                          ? FileImage(_image)
                          : NetworkImage(widget.user.imageUrl),
                      backgroundColor: Colors.transparent,
                      radius: 40,
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0x22000000),
                      child: Icon(
                        Icons.add_a_photo,
                        color: Color(0xDDFFFFFF),
                        size: 32,
                      ),
                      radius: 40,
                    )
                  ]),
                ),
                RoundedButton(
                    title: '保存',
                    color: Colors.blueAccent,
                    onPressed: () async {
                      if (_image != null) {
                        setState(() {
                          isShowSpinner = true;
                        });
                        await updateImage(widget.user.uid);
                        setState(() {
                          isShowSpinner = false;
                        });
                      }
                      Navigator.of(context).pop();
                      await widget.callback;
                    })
              ],
            ),
          )),
    );
  }
}
