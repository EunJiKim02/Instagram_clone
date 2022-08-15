import 'package:flutter/material.dart';

class DetailPostPage extends StatelessWidget {
  //const DetailPostPage({Key? key}) : super(key: key);

  final dynamic document;
  DetailPostPage(this.document);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("둘러보기",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold
          ),
        ),
      ),
      body:  _buildBody(),
    );
  }

Widget _buildBody() {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Padding(padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(document['userPhotoUrl']),
                    ),
                    Padding(padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      children: <Widget>[
                        Text(document['email'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(document['displayName'])
                      ],
                    ),
                    ),

                  ],
                ),
              ),
              Image.network(document['photoUrl']),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(document['contents']),
              )
            ],
          ),
        )
    );
}
}
