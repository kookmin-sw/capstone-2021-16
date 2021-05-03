import 'dart:io';

import 'package:app/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'notification.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();
final userReference = FirebaseFirestore.instance.collection('users');
// final _firestore = FirebaseFirestore.instance;

class Profile extends StatefulWidget {
  String currentUserUid;
  Profile({Key key, @required this.currentUserUid}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState(currentUserUid);
}

class _ProfileState extends State<Profile> {
  String currentUserUid;
  _ProfileState(this.currentUserUid); //uid 받아오기
  Map<String, dynamic> datas;

  @override
  void initState() {
    super.initState();
    currentUserUid = widget.currentUserUid; // 넘어온 uid 받기
    print(currentUserUid);
  }

  Future<void> _handleSignOut() async {
    // 로그아웃
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget _appbarWidget() {
    return AppBar(
      // AppBar
      elevation: 0,
      title: GestureDetector(
        onTap: () {
          // 클릭했을 때 Callback이 이 쪽으로 옴
          print("click");
        },
        child: Row(
          children: [
            SizedBox(width: 5), //Padding이랑 같은 효과
            Text("프로필"),
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotesList()), // Move to Notice
              );
            },
            icon: Image.asset('assets/images/bell.png'))
      ], // 가운데 이름
    );
  }

  // Widget _buildCard(BuildContext context) {
  //   return Card(
  //     child: ListTile(
  //       //leading: Image.network('https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/512x512/plain/user.png'),
  //       leading: Image.asset("assets/images/user.png"),
  //       title: Text('함석민'),
  //       subtitle: Text('hahmsm@kookmin.ac.kr'),

  //       trailing: IconButton(
  //         icon: Icon(Icons.settings),
  //         onPressed: () {
  //           // Navigator.pushNamed(context, '/profile-edit', arguments: user);
  //         },
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildBody(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Container(
  //       padding: EdgeInsets.all(10),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           _buildCard(context),
  //           //_buildSignOut(context),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  _createProfileView() {
    return FutureBuilder(
        future: userReference.doc(currentUserUid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator()); //데이터가 안왔을때 로딩처리
          }

          if (snapshot.hasError) {
            // 에러 로직처리

            return Center(
              child: Text("데이터 오류"),
            );
          }

          if (snapshot.hasData) {
            // 데이터가 있을 때만 데이터를 넘겨줌
            DocumentSnapshot ds = snapshot.data;
            datas = ds.data();
            print(datas); // 데이터 받아오기
            return Center(
              child: Container(
                child: Row(
                  children: [
                    Image.network(datas['url']),
                    Text(datas['username']),
                    Text(datas['email']),
                  ],
                ),
              ),
            );
          }

          return Center(
            child: Text("데이터가 없습니다."),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbarWidget(),
        body: Container(
            child: Center(
          child: Column(
            children: [
              // _buildBody(context),
              _createProfileView(),
              RaisedButton(
                onPressed: () {
                  print('로그아웃');
                  _handleSignOut();
                },
                child: Text('로그아웃'),
              ),
            ],
          ),
        )));
  }
}
