import 'package:app/data/memo.dart';
import 'package:flutter/material.dart';
import 'selectplace.dart';
import 'message.dart';
import 'login.dart';
import 'notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'calendar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await DotEnv().load('.env');
//   runApp(MyApp());
// }

// final promiseReference = FirebaseFirestore.instance.collection('promises');

class Prom {
  String promise_title = ''; //약속 제목
  String promise = ''; // 약속 내용
  String select_place = '';
  String select_num = '';
  bool repeat = false; // 반복
  bool place = false; //장소 등록 여부
  var date; //날짜
  Prom(this.promise_title, this.promise, this.select_place, this.select_num);
//, this.repeat, this.place, this.date);
  // , this.select_place, this.select_num, this.repeat, this.place, this.date
}



class AddPromise extends StatefulWidget {
  AddPromise({Key key}) : super(key: key);

  @override
  _AddPromiseState createState() => _AddPromiseState();
}

class _AddPromiseState extends State<AddPromise> {
  FirebaseDatabase _database;
  DatabaseReference reference;
  String _databaseURL = 'https://yaksok-4207d-default-rtdb.firebaseio.com/';
  List<Memo> memos = List();
  // Firestore firestore = Firestore.instance;

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
            Text("약속 추가"),
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
  final contentController = TextEditingController();
  var contentController2 = TextEditingController();
  final contentController3 = TextEditingController();
  final contentController4 = TextEditingController();
  final _category = ['스터디', '이벤트', '운동'];
  var _selectedValue = '스터디';
  String promise_title = ''; //약속 제목
  String promise = ''; // 약속 내용
  String select_place = '';
  String select_num = '';
  bool repeat = false; // 반복
  bool place = false; //장소 등록 여부
  var date; //날짜
  GooglePlace googlePlace = GooglePlace('AIzaSyAqbd581f-OHohqrxC8kdJ_Fje_5S212Ms');
  List<AutocompletePrediction> predictions = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbarWidget(),
        body:
          ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:20, left:30, right: 30),
                height: 50,
                child: Row(
                  children: [
                    TextButton(
                        child: Text("약속 카테고리"),
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(fontSize: 20),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 130),
                      child: DropdownButton(
                       value: _selectedValue, items: _category.map(
                           (value){
                         return DropdownMenuItem(
                           value: value, child: Text(value),
                         );
                       },
                     ).toList(),
                       onChanged: (value){
                         setState(() {
                           _selectedValue = value;
                         });
                       },

                     ),

                    )
                  ],
                )
              ),
            Container(
              // 약속 입력
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              height: 50,
              child: TextField(
                controller: contentController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: '약속 제목을 입력하세요.',
                ),
                style: TextStyle(fontSize: 20),
                maxLines: 1,
                onChanged: (Text) {
                  promise_title = Text; // 현재 Textfield의 내용을 저장
                  //print("$Text"); // 확인
                },
              ),
            ),
            Container(
              // 약속 입력
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              height: 150,
              child: TextField(
                controller: contentController2,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: '약속 내용을 입력하세요.',
                ),
                style: TextStyle(fontSize: 20),
                maxLines: 3,
                onChanged: (Text2) {
                  promise = Text2; // 현재 Textfield의 내용을 저장
                  //print("$Text"); // 확인
                },
              ),
            ),
            Container(
                color: Colors.white60,
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: DateTimePicker(
                  // controller: dateController,
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date',
                  timeLabelText: "Hour",
                  selectableDayPredicate: (date) {
                    // Disable weekend days to select from the calendar
                    if (date.weekday == 6 || date.weekday == 7) {
                      return false;
                    }
                    return true;
                  },
                  onChanged: (date) => print(date),
                  validator: (date) {
                    print(date);
                    return null;
                  },
                  onSaved: (date) => print(date),
                )),
            Container(
              // 반복 여부 설정
                color: Colors.white60,
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              child: Text("반복"),
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(fontSize: 20),
                              ))),
                      Container(
                        // 반복 여부 설정
                          margin: EdgeInsets.only(left: 220),
                          alignment: Alignment.centerRight,
                          child: Switch(
                            value: repeat,
                            onChanged: (value) {
                              setState(() {
                                repeat = value;
                              });
                            },
                            activeTrackColor: Colors.green,
                            activeColor: Colors.white10,
                          ))
                    ])),
            Container(
              // 장소 여부 설정
                color: Colors.white60,
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                    child: Text("장소"),
                                    style: TextButton.styleFrom(
                                      textStyle: TextStyle(fontSize: 20),
                                    ))),
                            Container(
                                margin: EdgeInsets.only(left: 180),
                                alignment: Alignment.centerRight,
                                child:TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => selectplace()), // Move to Message
                                      );
                                    },
                                    child: Text("지도 보기"),
                                    style: TextButton.styleFrom(
                                      textStyle: TextStyle(fontSize: 20),
                                    )
                                )),
                          ]),
                      Container(
                        margin: EdgeInsets.only(),
                        child: TextField(
                          controller: contentController3,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: '장소 입력',
                          ),
                          style: TextStyle(fontSize: 15),
                          maxLines: 1,
                          onChanged: (Text) {
                            select_place = Text; // 현재 Textfield의 내용을 저장
                            //print("$Text"); // 확인
                          },
                        ),
                      ),
                    ],
                  )
                 ),
            Container(
              // 모집인원 여부 설정
                color: Colors.white60,
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child:TextField(
                  controller: contentController4,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: '모집 인원',
                  ),
                  style: TextStyle(fontSize: 15),
                  maxLines: 1,
                  onChanged: (Text) {
                    select_num = Text; // 현재 Textfield의 내용을 저장
                    //print("$Text"); // 확인
                  },
                ),),
            Container(
              //추가하기 버튼
                margin: EdgeInsets.only(top: 30, right: 30, left: 240, bottom: 30),
                color: Colors.grey,
                child: TextButton(
                    onPressed: () {
                      // final prom = Prom(doc['promise_title'], doc['promise']);
                      _addProm(Prom(contentController.text, contentController2.text, contentController3.text, contentController4.text));
                    },
                    child: Text("약속 추가하기"),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                    )))
          ],

        ));
  }
  void _addProm(Prom prom) {
    FirebaseFirestore.instance
        .collection('promises')
        .add({'title': prom.promise_title, 'promise': prom.promise, 'select_place' : prom.select_place, 'num' : prom.select_num, 'repeat' : prom.repeat});
      //, 'place' : prom.place, 'date' : prom.date});
    //, this.select_place, this.select_num, this.repeat, this.place, this.date

  }
}


