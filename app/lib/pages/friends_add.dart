import 'package:app/pages/friends.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message.dart';
import 'package:app/pages/friends.dart';
import 'notification.dart';

CollectionReference userReference = FirebaseFirestore.instance.collection('users');
// final _firestore = FirebaseFirestore.instance;

class FriendsAdd extends StatefulWidget {
  String currentUserUid;
  FriendsAdd({Key key, @required this.currentUserUid}) : super(key: key);

  @override
  _FriendsAddState createState() => _FriendsAddState(currentUserUid);
}

class _FriendsAddState extends State<FriendsAdd> {
  String currentUserUid;
  _FriendsAddState(this.currentUserUid);

  final contentController = TextEditingController();
  String search_string = "검색 결과 없음";
  var user_list= "검색 결과 없음";
  var user_id = "id: ";
  var user_profilename = "";
  var user_email = "";
  var user_name = "";
  var user_url = "";
  Map<String, String> friend_inf;
  int count = 0;

  @override
  void initState() {
    super.initState();
    currentUserUid = widget.currentUserUid; // 넘어온 uid 받기

  }

  void changedata(){
    setState((){
      FirebaseFirestore.instance.collection("users").where("email", isEqualTo: search_string).get().then((QuerySnapshot ds){
        ds.docs.forEach((doc) => user_id = doc["id"]);
      });
      FirebaseFirestore.instance.collection("users").where("email", isEqualTo: search_string).get().then((QuerySnapshot ds){
        ds.docs.forEach((doc) => user_profilename = doc["profileName"]);
      });
      FirebaseFirestore.instance.collection("users").where("email", isEqualTo: search_string).get().then((QuerySnapshot ds){
        ds.docs.forEach((doc) => user_name = doc["username"]);
      });
      FirebaseFirestore.instance.collection("users").where("email", isEqualTo: search_string).get().then((QuerySnapshot ds){
        ds.docs.forEach((doc) => user_url = doc["url"]);
      });
    });
  }

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
            Text("친구 찾기"),
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Friends(currentUserUid: currentUserUid)), // Move to Message
              );
            }, icon: Image.asset('assets/images/cancel.png')),
      ], // 가운데 이름
    );
  }



  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbarWidget(),
        body: ListView(
          children:<Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, left: 30,),
              height: 40,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 300,
                    child: TextField(
                      controller: contentController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: '친구 검색(이메일)',
                      ),
                      style: TextStyle(fontSize: 20),
                      maxLines: 1,
                      onChanged: (Text) {
                        search_string = Text; // 현재 Textfield의 내용을 저장
                        //print("$Text"); // 확인
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: changedata,
                      icon: Image.asset('assets/images/search.png'))
                  ,]
              ),
            ),

                Container(
                  margin: EdgeInsets.only(top:20 ),
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: Text(
                      "프로필 : "+"$user_profilename",
                        textAlign: TextAlign.left),
                        style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: 20),
                        )
                      ),
                ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top:20 ),
                child: TextButton(
                    child: Text(
                        "닉네임 : " +"$user_name",
                        textAlign: TextAlign.left),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                    )
                ),
              ),
                Container(
                  //추가하기 버튼
                    margin: EdgeInsets.only(top: 30, right: 30, left: 240, bottom: 30),
                    child: OutlinedButton(
                        onPressed: () {
                          if(user_id != null) {
                            FirebaseFirestore.instance.collection("users").doc(
                                currentUserUid).update({
                              "friends": FieldValue.arrayUnion([
                                {'id': user_id, 'profileName': user_profilename, 'url': user_url}
                              ])
                            });
                          }
                        },
                        child: Text("친구 추가"),
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(fontSize: 20),
                        )))

    ],),);
  }
}
