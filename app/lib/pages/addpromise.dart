import 'package:flutter/material.dart';

class AddPromise extends StatefulWidget {
  AddPromise({Key key}) : super(key: key);

  @override
  _AddPromiseState createState() => _AddPromiseState();
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
          Text("약속추가"),
        ],
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {}, icon: Image.asset("assets/images/message.png")),
      IconButton(onPressed: () {}, icon: Image.asset("assets/images/bell.png"))
    ], // 가운데 이름
  );
}

class _AddPromiseState extends State<AddPromise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: Text("약속 추가 페이지"),
    );
  }
}
