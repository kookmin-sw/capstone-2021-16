import 'package:flutter/material.dart';

// class AddPromise extends StatefulWidget {
//   AddPromise({Key key}) : super(key: key);
//
//
//
//   @override
//   _AddPromiseState createState() => _AddPromiseState();
// }
//
// class _AddPromiseState extends State<AddPromise> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Text("약속 추가 페이지"),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app/addcontent.dart';
import 'package:app/content.dart';

class AddPromise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp(database),
        '/add': (context) => AddContentApp(database),
      },
    );
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'content_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE contents(id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "title TEXT, content TEXT, active BOOL)",
        );
      },
      version: 1,
    );
  }
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;

  DatabaseApp(this.db);

  @override
  State<StatefulWidget> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp> {
  Future<List<Content>> contentList;

  @override
  void initState() {
    super.initState();
    contentList = getContents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Center(
            child: FutureBuilder(
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return CircularProgressIndicator();
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          Content content = snapshot.data[index];
                          return ListTile(
                            title: Text(
                              content.title,
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Container(
                              child: Column(
                                children: <Widget>[
                                  Text(content.content),
                                  // Text('체크 : ${content.active.toString()}'),
                                  Container(
                                    height: 1,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                            onTap: () async {
                              Content result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('${content.id} : ${content.title}'),
                                      content: Text('Content를 체크하시겠습니까?'),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                // content.active == true
                                                //     ? content.active = false
                                                //     : content.active = true;
                                              });
                                              Navigator.of(context).pop(content);
                                            },
                                            child: Text('예')),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('아니요')),
                                      ],
                                    );
                                  });
                              if (result != null) {
                                _updateContent(result);
                              }
                            },
                            onLongPress: () async {
                              Content result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('${content.id} : ${content.title}'),
                                      content:
                                      Text('${content.content}를 삭제하시겠습니까?'),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(content);
                                            },
                                            child: Text('예')),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('아니요')),
                                      ],
                                    );
                                  });
                              if (result != null) {
                                _deleteContent(result);
                              }
                            },
                          );
                        },
                        itemCount: snapshot.data.length,
                      );
                    } else {
                      return Text('No data');
                    }
                }
                return CircularProgressIndicator();
              },
              future: contentList,
            ),
          ),
        ),
        floatingActionButton: Column(
          children: <Widget>[
            FloatingActionButton(
              onPressed: () async {
                final content = await Navigator.of(context).pushNamed('/add');
                if (content != null) {
                  _insertContent(content);
                }
              },
              heroTag: null,
              child: Icon(Icons.add),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: () async {
                _allUpdate();
              },
              heroTag: null,
              child: Icon(Icons.update),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ));
  }

  void _allUpdate() async {
    final Database database = await widget.db;
    await database.rawUpdate('update contents set active = 1 where active = 0');
    setState(() {
      contentList = getContents();
    });
  }

  void _deleteContent(Content content) async {
    final Database database = await widget.db;
    await database.delete('contents', where: 'id=?', whereArgs: [content.id]);
    setState(() {
      contentList = getContents();
    });
  }

  void _updateContent(Content content) async {
    final Database database = await widget.db;
    await database.update(
      'contents',
      content.toMap(),
      where: 'id = ? ',
      whereArgs: [content.id],
    );
    setState(() {
      contentList = getContents();
    });
  }

  void _insertContent(Content content) async {
    final Database database = await widget.db;
    await database.insert('contents', content.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      contentList = getContents();
    });
  }

  Future<List<Content>> getContents() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('contents');

    return List.generate(maps.length, (i) {
      bool active = maps[i]['active'] == 1 ? true : false;
      return Content(
          title: maps[i]['title'].toString(),
          content: maps[i]['content'].toString(),
          id: maps[i]['id']);
    });
  }
}
