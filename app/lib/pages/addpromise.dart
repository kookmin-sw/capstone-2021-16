import 'package:flutter/material.dart';
import 'package:project1/pages/selectplace.dart';
import 'message.dart';
import 'notification.dart';
import 'dart:typed_data';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:google_place/google_place.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'calendar.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await DotEnv().load('.env');
//   runApp(MyApp());
// }


class AddPromise extends StatefulWidget {
  AddPromise({Key key}) : super(key: key);

  @override
  _AddPromiseState createState() => _AddPromiseState();
}

class _AddPromiseState extends State<AddPromise> {
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
                MaterialPageRoute(builder: (context) => MessageList()), // Move to Message
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
  final _controller = TextEditingController();
  String promise = '';
  bool repeat = false;
  bool place = false;
  var date;
  GooglePlace googlePlace = GooglePlace('AIzaSyAqbd581f-OHohqrxC8kdJ_Fje_5S212Ms');
  List<AutocompletePrediction> predictions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbarWidget(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // 약속 입력
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              height: 150,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: '약속 내용을 입력하세요.',
                ),
                style: TextStyle(fontSize: 20),
                maxLines: 5,
                onChanged: (Text) {
                  promise = Text; // 현재 Textfield의 내용을 저장
                  //print("$Text"); // 확인
                },
              ),
            ),
            Container(
                color: Colors.white60,
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: DateTimePicker(
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
                child: Row(
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
                              child: Text("장소 추가"),
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(fontSize: 20),
                              )
                          )),
                    ])),
            Container(
              // 모집인원 여부 설정
                color: Colors.white60,
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              child: Text("모집 인원"),
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(fontSize: 20),
                              ))),
                    ])),
            Container(
              //추가하기 버튼
                margin: EdgeInsets.only(top: 30, right: 30, left: 240),
                alignment: Alignment.centerRight,
                color: Colors.grey,
                child: TextButton(
                    child: Text("약속 추가하기"),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                    )))
          ],
        ));
  }
}
