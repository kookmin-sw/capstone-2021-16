import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../data/memo.dart';

class AddPromise extends StatefulWidget {
  final DatabaseReference reference;
  AddPromise(this.reference);

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
  TextEditingController titleController;
  TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('약속 추가'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: '약속 이름', fillColor: Colors.blueAccent),
              ),
              Expanded(
                  child: TextField(
                    controller: contentController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 100,
                    decoration: InputDecoration(labelText: '내용'),
                  )),
              FlatButton(
                onPressed: () {
                  widget.reference
                      .push()
                      .set(Memo(
                      titleController.value.text,
                      contentController.value.text,
                      DateTime.now().toIso8601String())
                      .toJson())
                      .then((_) {
                    Navigator.of(context).pop();
                  });
                },
                child: Text('추가하기'),
                shape:
                OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              )
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: Text("약속 추가"),
    // );
  }
}
