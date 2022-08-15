import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User user;

  HomePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Instagram Clone',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold
            ),
          )
      ),
      body: _buildBody(

      ),
    );
  }

  Widget _buildBody(){
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Text('Instagram에 오신 것을 환영합니다.',
                  style: TextStyle(fontSize: 24.0),
                ),
                Padding(padding: EdgeInsets.all(8.0),),
                Text('사진과 동영상을 보려면 팔로우 하세요'
                ),
                Padding(padding: EdgeInsets.all(16.0),),
                SizedBox(
                  width: 260.0,
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(8.0),),
                        SizedBox(
                          width: 80.0,
                          height: 80.0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.photoURL),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0),),
                        Text(user.email,
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(user.displayName),
                        Padding(padding: EdgeInsets.all(8.0),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 70.0,
                              height: 70.0,
                              child: Image.network('https://www.prfish.com/shop/data/editor/1503450742.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(1.0),),
                            SizedBox(
                              width: 70.0,
                              height: 70.0,
                              child: Image.network('https://t1.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/4arX/image/qgm4f5y9hOHP4b1opI1Mu_qIlIU.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(1.0),),
                            SizedBox(
                              width: 70.0,
                              height: 70.0,
                              child: Image.network('https://upload.wikimedia.org/wikipedia/commons/d/d0/Tortoise_Fred.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(1.0),),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(4.0),),
                        Text('페이스북 친구'),
                        Padding(padding: EdgeInsets.all(4.0),),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                            child: const Text('팔로우'),
                            onPressed: () => print('팔로우 클릭')),
                        Padding(padding: EdgeInsets.all(4.0),),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}