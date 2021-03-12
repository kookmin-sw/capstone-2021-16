import 'package:flutter/material.dart';

class Friends extends StatefulWidget {
  Friends({Key key}) : super(key: key);

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("친구페이지"),
    );
  }
}
