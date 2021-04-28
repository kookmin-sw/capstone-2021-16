import 'package:app/pages/addpromise.dart';
import 'package:app/pages/calendar.dart';
import 'package:app/pages/friends.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/profile.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  String _databaseURL = 'https://yaksok-4207d-default-rtdb.firebaseio.com/';
  List<Memo> memos = List();
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
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

    GoogleSignInAccount currentUser = _googleSignIn.currentUser;
    print(currentUser);
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
        return AddPromise(); // 약속추가페이지
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
      String iconName, String label, int index) {
    return BottomNavigationBarItem(
      icon: _currentPageIndex == index
          ? new Image.asset("assets/images/${iconName}_on.png")
          : new Image.asset("assets/images/${iconName}.png"),
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
          _bottomNavigationBarItem("home", "홈", 0),
          _bottomNavigationBarItem("friends", "친구", 1),
          _bottomNavigationBarItem("plus", "약속추가", 2),
          _bottomNavigationBarItem("calendar", "캘린더", 3),
          _bottomNavigationBarItem("profile", "프로필", 4),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
