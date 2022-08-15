import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePage extends StatefulWidget {
  final User user;

  CreatePage(this.user);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.send),
          color: Colors.black,
          onPressed: (){
            print('클릭');

            final firebaseStorageRef = FirebaseStorage.instance
                .ref()
                .child('post')
                .child('${DateTime.now().millisecondsSinceEpoch}.png');

            final task = firebaseStorageRef.putFile(
                _image, SettableMetadata(contentType: 'image/png'));

            task.then((value) {
              var downloadUrl = value.ref.getDownloadURL();

              downloadUrl.then((uri) {
                var doc = FirebaseFirestore.instance.collection('post').doc();
                doc.set({
                  'id': doc.id,
                  'photoUrl': uri.toString(),
                  'contents': textEditingController.text,
                  'email': widget.user.email,
                  'displayName': widget.user.displayName,
                  'userPhotoUrl': widget.user.photoURL
                }).then((onValue) {
                  // 완료 후 앞 화면으로 이동
                  Navigator.pop(context);
                });
              });
            });
          },
        )
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _image == null ? Text('No Image') : Image.file(_image),
          TextField(
            decoration: InputDecoration(hintText: '내용을 입력하세요'),
            controller: textEditingController,
          )
        ],
      ),
    );
  }

  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    _uploadPost(context);
  }
  Future<void> _uploadPost(BuildContext context) async {
    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('post')
        .child('${DateTime.now().millisecondsSinceEpoch}.png');

    final task = await firebaseStorageRef.putFile(
        _image, SettableMetadata(contentType: 'image/png'));

    final uri = await task.ref.getDownloadURL();

    final doc = FirebaseFirestore.instance.collection('post').doc();
    await doc.set({
      'id': doc.id,
      'photoUrl': uri.toString(),
      'contents': textEditingController.text,
      'email': widget.user.email,
      'displayName': widget.user.displayName,
      'userPhotoUrl': widget.user.photoURL
    });

    // 완료 후 앞 화면으로 이동
    Navigator.pop(context);
  }


//
// Future<void> _getImage() async {
//   File image = await ImagePicker.pickImage(
//       source: ImageSource.gallery
//   );
//   setState(() {
//     _image = image;
//   });
// }
}