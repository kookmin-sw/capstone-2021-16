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
  // TextEditingController

  String promise = '';
  bool repeat = false;
  bool place = false;
  final _month = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
  final _date1 = ['1일', '2일', '3일', '4일', '5일', '6일', '7일', '8일', '9일', '10일', '11일', '12일', '13일', '14일', '15일', '16일', '17일', '18일', '19일', '20일', '21일', '22일', '23일', '24일', '25일', '26일', '27일', '28일', '29일', '30일', '31일'];
  final _date2 = ['1일', '2일', '3일', '4일', '5일', '6일', '7일', '8일', '9일', '10일', '11일', '12일', '13일', '14일', '15일', '16일', '17일', '18일', '19일', '20일', '21일', '22일', '23일', '24일', '25일', '26일', '27일', '28일', '29일', '30일'];
  final _date3 = ['1일', '2일', '3일', '4일', '5일', '6일', '7일', '8일', '9일', '10일', '11일', '12일', '13일', '14일', '15일', '16일', '17일', '18일', '19일', '20일', '21일', '22일', '23일', '24일', '25일', '26일', '27일', '28일', '29일'];
  final _time = ['00시', '01시', '02시', '03시', '04시', '05시', '06시', '07시', '08시', '09시', '10시', '11시', '12시', '13시', '14시', '15시', '16시', '17시', '18시', '19시', '20시', '21시', '22시', '23시'];
  final _minute = ['00분', '05분', '10분', '15분', '20분', '25분', '30분', '35분', '40분', '45분', '50분', '55분' ];
  var selectmonth= '1월';
  var selectdate= '1일';
  var starttime ='00시';
  var startminute = "00분";
  var endtime = "00시";
  var endminute = "00분";
  String year, month, yearMonthDay, startYMDT, endYMDT;
  TextEditingController ymdtController1 = TextEditingController();
  TextEditingController ymdtController2 = TextEditingController();
  bool autovalidate = false;
  // var date =
  yearMonthDayTimePicker1() async {
    final year = DateTime.now().year;
    String hour, min;

    final DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(year),
      lastDate: DateTime(year + 10),
    );

    if (dateTime != null) {
      final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 0, minute: 0),
      );

      if (pickedTime != null) {
        if (pickedTime.hour < 10) {
          hour = '0' + pickedTime.hour.toString();
        } else {
          hour = pickedTime.hour.toString();
        }

        if (pickedTime.minute < 10) {
          min = '0' + pickedTime.minute.toString();
        } else {
          min = pickedTime.minute.toString();
        }

        ymdtController1.text = '${dateTime.toString().split(' ')[0]} $hour:$min';
      }
    }
  }
  yearMonthDayTimePicker2() async {
    final year = DateTime.now().year;
    String hour, min;

    final DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(year),
      lastDate: DateTime(year + 10),
    );

    if (dateTime != null) {
      final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 0, minute: 0),
      );

      if (pickedTime != null) {
        if (pickedTime.hour < 10) {
          hour = '0' + pickedTime.hour.toString();
        } else {
          hour = pickedTime.hour.toString();
        }

        if (pickedTime.minute < 10) {
          min = '0' + pickedTime.minute.toString();
        } else {
          min = pickedTime.minute.toString();
        }

        ymdtController2.text = '${dateTime.toString().split(' ')[0]} $hour:$min';
      }
    }
  }
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('약속 추가'),
      // ),
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
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      ),
                      hintText: '약속 내용을 입력하세요.',
                    ),
                    style: TextStyle(fontSize: 20),
                    maxLines: 5,
                    onChanged: (Text){
                      promise = Text; // 현재 Textfield의 내용을 저장
                      //print("$Text"); // 확인
                    },
                  )),
              Container(
                  margin: EdgeInsets.only(top:20, left:30, right:30),
                  color: Colors.white60,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: yearMonthDayTimePicker1,
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: ymdtController1,
                              decoration: InputDecoration(
                                labelText: '언제 만날지 정해주세요',
                                border: OutlineInputBorder(),
                                filled: true,
                              ),
                              onSaved: (val) {
                                startYMDT = ymdtController1.text;
                              },
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Year-Month-Date-Time is necessary';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: yearMonthDayTimePicker2,
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: ymdtController2,
                              decoration: InputDecoration(
                                labelText: '언제 헤어질지 정해주세요',
                                border: OutlineInputBorder(),
                                filled: true,
                              ),
                              onSaved: (val) {
                                endYMDT = ymdtController2.text;
                              },
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Year-Month-Date-Time is necessary';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        //           Container(
                        //               alignment: Alignment.centerLeft,
                        //               child: TextButton(
                        //                   child: Text("날짜"),
                        //                   style:TextButton.styleFrom(
                        //                     textStyle: TextStyle(fontSize: 20),
                        //                   )
                        //               )
                        //           ),
                        //           Container(
                        //               margin: EdgeInsets.only(left: 120),
                        //               child: DropdownButton(
                        //                 value: selectmonth,
                        //                 items: _month.map(
                        //                       (value){
                        //                     return DropdownMenuItem(
                        //                       value: value,
                        //                       child: Text(value),
                        //                     );
                        //                   },
                        //
                        //                 ).toList(),
                        //                 onChanged: (value){
                        //                   setState(() {
                        //                     selectmonth = value;
                        //                   });
                        //                 },
                        //
                        //               )
                        //           ),
                        //           Container(
                        //               margin: EdgeInsets.only(left: 20),
                        //               child: DropdownButton(
                        //                 value: selectdate,
                        //                 items: _date1.map(
                        //                       (value){
                        //                     return DropdownMenuItem(
                        //                       value: value,
                        //                       child: Text(value),
                        //                     );
                        //                   },
                        //                 ).toList(),
                        //                 onChanged: (value){
                        //                   setState(() {
                        //                     selectdate = value;
                        //                   });
                        //                 },
                        //               )
                        //           ),
                        //         ]
                        //     )
                        // ),
                        // Container( // 시간설정
                        //     margin: EdgeInsets.only(top:20, left:30, right:30),
                        //     color: Colors.white60,
                        //     child: Row(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: <Widget>[
                        //           Container(
                        //               alignment: Alignment.centerLeft,
                        //               child: TextButton(
                        //                   child: Text("시간"),
                        //                   style:TextButton.styleFrom(
                        //                     textStyle: TextStyle(fontSize: 20),
                        //                   )
                        //               )
                        //           ),
                        //           Container(
                        //               margin: EdgeInsets.only(left: 10),
                        //               child: DropdownButton(
                        //                 value: starttime,
                        //                 items: _time.map(
                        //                       (value){
                        //                     return DropdownMenuItem(
                        //                       value: value,
                        //                       child: Text(value),
                        //                     );
                        //                   },
                        //                 ).toList(),
                        //                 onChanged: (value){
                        //                   setState(() {
                        //                     starttime = value;
                        //                   });
                        //                 },
                        //               )
                        //           ),
                        //           Container(
                        //               margin: EdgeInsets.only(left: 5),
                        //               child: DropdownButton(
                        //                 value: startminute,
                        //                 items: _minute.map(
                        //                       (value){
                        //                     return DropdownMenuItem(
                        //                       value: value,
                        //                       child: Text(value),
                        //                     );
                        //                   },
                        //                 ).toList(),
                        //                 onChanged: (value){
                        //                   setState(() {
                        //                     startminute = value;
                        //                   });
                        //                 },
                        //               )
                        //           ),
                        //           Container(
                        //               width: 15,
                        //               child: TextButton(
                        //                   child: Text("~"),
                        //                   style:TextButton.styleFrom(
                        //                     textStyle: TextStyle(fontSize: 15),
                        //                   )
                        //               )
                        //           ),
                        //           Container(
                        //               margin: EdgeInsets.only(left: 10),
                        //               child: DropdownButton(
                        //                 value: endtime,
                        //                 items: _time.map(
                        //                       (value){
                        //                     return DropdownMenuItem(
                        //                       value: value,
                        //                       child: Text(value),
                        //                     );
                        //                   },
                        //                 ).toList(),
                        //                 onChanged: (value){
                        //                   setState(() {
                        //                     endtime = value;
                        //                   });
                        //                 },
                        //               )
                        //           ),
                        //           Container(
                        //               margin: EdgeInsets.only(left: 5),
                        //               child: DropdownButton(
                        //                 value: endminute,
                        //                 items: _minute.map(
                        //                       (value){
                        //                     return DropdownMenuItem(
                        //                       value: value,
                        //                       child: Text(value),
                        //                     );
                        //                   },
                        //                 ).toList(),
                        //                 onChanged: (value){
                        //                   setState(() {
                        //                     endminute = value;
                        //                   });
                        //                 },
                        //               )
                        //           ),
                      ]
                  )
              ),

              FlatButton(
                onPressed: () {
                  widget.reference
                      .push()
                      .set(Memo(
                      titleController.value.text,
                      contentController.value.text,
                      ymdtController1.value.text,
                      ymdtController2.value.text,
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
