import 'package:app/pages/addpromise.dart';
import 'package:app/pages/calendar.dart';
import 'package:app/pages/friends.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/profile.dart';

import 'package:flutter/material.dart';

import './data/memo.dart';
import 'package:firebase_database/firebase_database.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  FirebaseDatabase _database;
  DatabaseReference reference;
  String _databaseURL = '### 데이터베이스 URL 넣기 ###';
  List<Memo> memos = List();

  int _currentPageIndex; // 페이지 인덱스

  @override // 데이터 다루는 곳
  void initState() {
    super.initState();
    _currentPageIndex = 0; //현재 페이지 인덱스 ( 홈 )

    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database.reference().child('memo');

    reference.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
    });
  }

  Widget _appbarWidget() {
    return AppBar(
      // AppBar
      title: GestureDetector(
        onTap: () {
          // 클릭했을 때 Callback이 이 쪽으로 옴
          print("click");
        },
        child: Row(
          children: [
            SizedBox(width: 5), //Padding이랑 같은 효과
            Text("Appname"),
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {}, icon: Image.asset("assets/images/message.png")),
        IconButton(
            onPressed: () {}, icon: Image.asset("assets/images/bell.png"))
      ], // 가운데 이름
    );
  }

  /// 네비게이션 분기하는 로직
  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return Home(); // 홈 화면
        break;
      case 1:
        return Friends(); // 친구 목록 페이지
        break;
      case 2:
        return AddPromise(reference); // 약속추가페이지
        break;
      case 3:
        return Calendar(); // 캘린더 페이지
        break;
      case 4:
        return Profile(); // 프로필 페이지
        break;
    }
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
      icon: Image.asset("assets/images/${iconName}.png"),
      label: label,
    );
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 네비게이션바 애니메이션
        onTap: (int index) {
          print(index);
          setState(() {
            _currentPageIndex = index;
          });
        },
        currentIndex: _currentPageIndex,
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.black),
        items: [
          _bottomNavigationBarItem("home", "홈"),
          _bottomNavigationBarItem("friends", "친구"),
          _bottomNavigationBarItem("plus", "약속추가"),
          _bottomNavigationBarItem("calendar", "알림"),
          _bottomNavigationBarItem("profile", "프로필"),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
      endDrawer: Drawer(
        child: Text("슬라이드 메뉴"),
      ),
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
    );
  }
}
