import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:english_words/english_words.dart';

class Friends extends StatefulWidget {
  //Friends({Key key}) : super(key: key);

  @override
  _FriendsState createState() => _FriendsState();

}

class _FriendsState extends State<Friends> {
  @override
  /*Widget build(BuildContext context) {
    return Scaffold(
      body: Text("페이지"),
    );
  }*/

  // db 정보 list 생성
  static const String _title = 'Friend List';
  static const List<String> _data = [
    '김현서',
    '이헌수',
    '이선용',
    '이주윤',
    '함석민'
  ];

  // 리스트 뷰 만들기
  Widget _buildStaticListView() {
    final already = _data.contains(context);
    return ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            title: Text(_data[i],
              style: TextStyle(
                  fontSize: 20
              ),),

            trailing: Icon(   // 하트 이모티콘
              //already ? Icons.favorite :
              Icons.favorite_border,
              color: already ? Colors.red : null,
            ),

            onTap: () {
              setState(() {
                if(already) {
                  _data.remove(context);
                } else {
                 //_data.add(context); // 에러뜸 왜 에러냐
                }
              });
            },
          );
        }
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //appBar: AppBar(title: Text(_title)), // -> appbar 지웠음
        body: _buildStaticListView(),
      ),
    );
  }

}
