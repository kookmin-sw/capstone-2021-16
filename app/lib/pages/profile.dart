import 'package:flutter/material.dart';
import 'message.dart';
import 'notification.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                MaterialPageRoute(builder: (context) => MessagesList()), // Move to Message
              );
            }, icon: Image.asset('assets/images/message.png')),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotesList()), // Move to Notice
              );
            }, icon: Image.asset('assets/images/bell.png'))
      ], // 가운데 이름
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: Text("프로필 페이지"),
    );
  }
}
