import 'package:app/pages/message.dart';
import 'package:app/pages/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Detailpage extends StatefulWidget {
  Map<String, dynamic> promisedata;
  String currentUserUid;
  Detailpage(
      {Key key, @required this.promisedata, @required this.currentUserUid})
      : super(key: key);

  @override
  _DetailpageState createState() =>
      _DetailpageState(promisedata, currentUserUid);
}

class _DetailpageState extends State<Detailpage> {
  Map<String, dynamic> promisedata;
  String currentUserUid;
  List<Map<String, dynamic>> participantsdata = [];
  _DetailpageState(Map<String, dynamic> promisedata, String currentUserUid);
  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 1),
    () => 'Data Loaded',
  );
  bool writercheck = false;
  @override
  void initState() {
    super.initState();
    promisedata = widget.promisedata;
    currentUserUid = widget.currentUserUid;
    promisedata['participants'].map((participant) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(participant)
          .get()
          .then((DocumentSnapshot ds) {
        print(ds.data());
        participantsdata.add(ds.data());
      });
    }).toList();
    if (promisedata['writer'] == currentUserUid) {
      setState(() {
        writercheck = true;
      });
    }
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
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset("assets/images/cancel.png"))
      ], // 가운데 이름
    );
  }

  Widget _topContentWidget(Size size) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
              ),
              Text(
                promisedata["title"],
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
                width: 0.0,
              ),
              Row(
                children: [
                  Image(
                    image: AssetImage('assets/images/location.png'),
                  ),
                  SizedBox(
                    height: 0.0,
                    width: 5.0,
                  ),
                  Text(
                    promisedata['location'],
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
                width: 0.0,
              ),
              Row(
                children: [
                  Image(
                    image: AssetImage('assets/images/time.png'),
                  ),
                  SizedBox(
                    height: 0.0,
                    width: 10.0,
                  ),
                  Text(
                    promisedata['date'],
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

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
            SizedBox(
              width: 0,
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "참여자",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            promisedata['participants'].length.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 120.0,
                        child: FutureBuilder(
                            future: _calculation,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    children:
                                        participantsdata.map((participant) {
                                      return ListTile(
                                        title: Container(
                                          child: Row(
                                            children: [
                                              Image.network(
                                                participant['url'],
                                                width: 32,
                                                height: 32,
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(participant['profileName']),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList());
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: 80.0,
                child: Column(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "내용",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(promisedata['contents'])
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            writercheck
                ? Container(
                    height: 30.0,
                    child: RaisedButton(
                      color: Color(0xff23D990),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30),
                      ),
                      child: Text(
                        "취소하기",
                        style: TextStyle(color: Color(0xffffffff)),
                      ),
                    ),
                  )
                : Container(
                    height: 30.0,
                    child: RaisedButton(
                      color: Color(0xff23D990),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30),
                      ),
                      child: Text(
                        "신청하기",
                        style: TextStyle(color: Color(0xffffffff)),
                      ),
                    ),
                  )
          ],
        )),
      ),
    );
  }
}
