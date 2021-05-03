import 'package:app/pages/addpromise.dart';
import 'package:app/pages/calendar.dart';
import 'package:app/pages/friends.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  // 구글 로그인 정보
  final FirebaseAuth _auth = FirebaseAuth.instance; // 현재 로그인 정보 받기 위한 것
  String _currentUserUid; // 구글 UID : ( Home, Profile, Addpromise 등) 에 넘길 uid
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

    _auth.authStateChanges().listen((User user) {
      // _currentUser = user;
      List<UserInfo> userInfo = user.providerData; // 구글 유저정보
      // 현재 유저 uid 가져오기 추후에 페이지로 넘길 것
      print(userInfo[0].uid); // 구글 uid
      _currentUserUid = userInfo[0].uid;
    });
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
        return Profile(currentUserUid: _currentUserUid); // 프로필 페이지
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

class FirebaseUser {}
