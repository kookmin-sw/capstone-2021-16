import 'dart:io';

import 'package:app/pages/friends_add.dart';
import 'package:app/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'message.dart';
import 'notification.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();
final userReference = FirebaseFirestore.instance.collection('users');
// final _firestore = FirebaseFirestore.instance;

class Friends extends StatefulWidget {
  String currentUserUid;
  Friends({Key key, @required this.currentUserUid}) : super(key: key);

  @override
  _FriendsState createState() => _FriendsState(currentUserUid);
}

class _FriendsState extends State<Friends> {
  String currentUserUid;
  _FriendsState(this.currentUserUid);
  Map<String, dynamic> friends_datas;
  @override
  void initState() {
    super.initState();
    currentUserUid = widget.currentUserUid; // 넘어온 uid 받기
    print(currentUserUid);
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
            Text("친구 목록"),
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
            icon: Image.asset('assets/images/bell.png')),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FriendsAdd(currentUserUid: currentUserUid)), // Move to Notice
              );
            },
            icon: Image.asset('assets/images/friendsadd.png'))
      ], // 가운데 이름
    );
  }

  _createFriendList() {
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
            friends_datas = ds.data();
            print(friends_datas); // 데이터 받아오기
            var friends_list= friends_datas['friends'];
            return ListView.builder(
                itemCount: friends_list.length,
                itemBuilder: (BuildContext context, int index){
                  return Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top:10, left:30, right: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 30, right: 30, top:10),
                                child: Image.network(
                                  ('${friends_list[index]['url']}'),
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child:TextButton(
                                    child: Text('${friends_list[index]['profileName']}', textAlign: TextAlign.left),
                                    style: TextButton.styleFrom(
                                      textStyle: TextStyle(fontSize: 20),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                  );
                });
          }

          return Center(
            child: Text("현재 등록된 친구가 없습니다."),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbarWidget(),
        body: _createFriendList()
    );
  }
}