import 'package:app/repository/contents_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'message.dart';
import 'notification.dart';

final userReference = FirebaseFirestore.instance.collection('users');

class Home extends StatefulWidget {
  String currentUserUid;
  Home({Key key, @required this.currentUserUid}) : super(key: key);
  @override
  _HomeState createState() => _HomeState(currentUserUid);
}

class _HomeState extends State<Home> {
  String currentUserUid;
  _HomeState(this.currentUserUid);
  ContentsRepository contentsRepository;
  Map<String, dynamic> userdatas;
  Stream<QuerySnapshot> currentStream;
  String currentMenu; // 초기 데이터는 확정된 약속

  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 1),
    () => 'Data Loaded',
  );

  Color btn_1_color,
      btn_2_color,
      btn_3_color,
      txt_1_color,
      txt_2_color,
      txt_3_color;
  String dynamic_txt = "확정된 약속 리스트";
  @override
  void initState() {
    super.initState();
    currentMenu = "confirm";
    currentUserUid = widget.currentUserUid;
    btn_1_color = Color(0xffffffff);
    btn_2_color = Color(0xff18A0FB);
    btn_3_color = Color(0xff18A0FB);
    txt_1_color = Color(0xff000000);
    txt_2_color = Color(0xffffffff);
    txt_3_color = Color(0xffffffff);
    currentStream = FirebaseFirestore.instance
        .collection("promises")
        .where("confirm?", isEqualTo: true)
        .snapshots();
    dynamic_txt = "확정된 약속 리스트";
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserUid)
        .get()
        .then((DocumentSnapshot ds) {
      userdatas = ds.data();
    });
    // print(datas);
  }

  Widget _topContentWidget(Size size) {
    return FutureBuilder(
        future: _calculation,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(userdatas);
            return Container(
                height: size.height * 0.2, // 상단 카테코리 (확정된 약속, 나의 약속, 약속찾기)
                decoration: BoxDecoration(
                  // 박스 Radius 설정
                  color: Color(0xff18A0FB),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.0,
                      height: 1.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // 프로필 들어가야함
                        SizedBox(
                          height: 0.0,
                          width: 40.0,
                        ),
                        Image.network(
                          userdatas["url"],
                          width: 32,
                          height: 32,
                        ),
                        SizedBox(
                          height: 0.0,
                          width: 10.0,
                        ),
                        Text(
                          userdatas["username"] + " 님의 약속",
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      // 카테고리 Container
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 버튼 모음

                          RaisedButton(
                            child: Text(
                              '확정된 약속',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: txt_1_color,
                              ),
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30),
                            ),
                            elevation: 0,
                            color: btn_1_color,
                            onPressed: () {
                              setState(() {
                                currentMenu = "confirm";
                                btn_1_color = Color(0xffffffff);
                                btn_2_color = Color(0xff18A0FB);
                                btn_3_color = Color(0xff18A0FB);
                                txt_1_color = Color(0xff000000);
                                txt_2_color = Color(0xffffffff);
                                txt_3_color = Color(0xffffffff);
                                dynamic_txt = "확정된 약속 리스트";
                                currentStream = FirebaseFirestore.instance
                                    .collection("promises")
                                    .where("confirm?", isEqualTo: true)
                                    .snapshots();
                              });
                            },
                          ),

                          RaisedButton(
                            child: Text(
                              '나의 약속',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: txt_2_color,
                              ),
                            ),
                            color: btn_2_color,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30),
                            ),
                            elevation: 0,
                            onPressed: () {
                              setState(() {
                                currentMenu = "mypromise";
                                btn_1_color = Color(0xff18A0FB);
                                btn_2_color = Color(0xffffffff);
                                btn_3_color = Color(0xff18A0FB);
                                txt_1_color = Color(0xffffffff);
                                txt_2_color = Color(0xff000000);
                                txt_3_color = Color(0xffffffff);
                                dynamic_txt = "나의 약속 리스트";

                                currentStream = FirebaseFirestore.instance
                                    .collection("promises")
                                    .where("writer", isEqualTo: currentUserUid)
                                    .where("confirm?", isEqualTo: false)
                                    .snapshots();
                              });
                            },
                          ),

                          RaisedButton(
                            child: Text(
                              '약속 찾기',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: txt_3_color,
                              ),
                            ),
                            color: btn_3_color,
                            elevation: 0,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30),
                            ),
                            onPressed: () {
                              setState(() {
                                currentMenu = "searchpromise";
                                btn_1_color = Color(0xff18A0FB);
                                btn_2_color = Color(0xff18A0FB);
                                btn_3_color = Color(0xffffffff);
                                txt_1_color = Color(0xffffffff);
                                txt_2_color = Color(0xffffffff);
                                txt_3_color = Color(0xff000000);
                                dynamic_txt = "약속 찾기";
                                currentStream = FirebaseFirestore.instance
                                    .collection("promises")
                                    .where("confirm?", isEqualTo: false)
                                    .where("writer",
                                        isNotEqualTo: currentUserUid)
                                    .snapshots();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _listWidget() {
    return StreamBuilder(
        //데이터 API 통신 ( contents_repository에 있는 데이터를 불러옴)
        stream: currentStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // return _makeDataList(snapshot.data);
            return Center(
              child: Text("약속이 없습니다."),
            );
          } else {
            List<DocumentSnapshot> documents = snapshot.data.docs;
            return ListView(
              children: documents.map((document) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                document["writerurl"],
                                width: 32,
                                height: 32,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document['title'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                    width: 0.0,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/location.png'),
                                      ),
                                      SizedBox(
                                        height: 0.0,
                                        width: 5.0,
                                      ),
                                      Text(
                                        document['location'],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                    width: 0.0,
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/time.png'),
                                      ),
                                      SizedBox(
                                        height: 0.0,
                                        width: 5.0,
                                      ),
                                      Text(
                                        document['date'],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 0.0,
                                width: 10.0,
                              ),
                              Text('인원')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
            // return Center(
            //   child: Text("데이터"),
            // );
          }
        });
    //
  }

  Widget _mainappbarWidget() {
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
            Image.asset("assets/images/appicon.png"),
            SizedBox(width: 10),
            Text(
              "알찬약속",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MessagesList()), // Move to Message
              );
            },
            icon: Image.asset("assets/images/home_message.png")),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotesList()), // Move to Notice
              );
            },
            icon: Image.asset("assets/images/home_alarm.png"))
      ], // 가운데 이름
    );
  }

// 빌드 구간
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff18A0FB),
      ),
      home: Scaffold(
        appBar: _mainappbarWidget(),
        body: Center(
            child: Column(
          children: [
            _topContentWidget(size), //

            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 0.0,
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30.0,
                      height: 0,
                    ),
                    new Text(
                      dynamic_txt != null ? dynamic_txt : 'default value',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 0.0,
                  height: 10.0,
                ),
              ],
            ),

            Expanded(child: _listWidget()), // 리스트
          ],
        )),
      ),
    );
  }
}
