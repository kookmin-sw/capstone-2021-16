
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import 'content.dart';

class AddContentApp extends StatefulWidget {
  final Future<Database> db;

  AddContentApp(this.db);

  @override
  State<StatefulWidget> createState() => _AddContentApp();
}

class _AddContentApp extends State<AddContentApp> {
  TextEditingController titleController;
  TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = new TextEditingController();
    contentController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: '약속 이름'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: contentController,
                  decoration: InputDecoration(labelText: '약속 내용'),
                ),
              ),
              RaisedButton(
                onPressed: (){
                  Content content = Content(
                      title: titleController.value.text,
                      content: contentController.value.text,
                     );
                  Navigator.of(context).pop(content);
                },
                child: Text('추가하기'),
              )
            ],
          ),
        ),
      ),
    );
  }
}