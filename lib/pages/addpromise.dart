import 'package:flutter/material.dart';

class AddPromise extends StatefulWidget {
  AddPromise({Key key}) : super(key: key);

  @override
  _AddPromiseState createState() => _AddPromiseState();
}

class _AddPromiseState extends State<AddPromise> {
  final _controller = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container( // 약속 입력
            margin:  EdgeInsets.only(top:20, left: 30, right: 30),
            height: 150,
            child: TextField(
              controller: _controller,
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
            ),
          ),
          Container( // 반복 여부 설정
            color: Colors.white60 ,
            margin: EdgeInsets.only(top:20, left:30, right:30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: Text("반복"),
                    style:TextButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                    )
                  )
                ),
                Container( // 장소 여부 설정
                  margin: EdgeInsets.only(left: 220),
                  alignment: Alignment.centerRight,
                  child: Switch(
                    value: repeat,
                    onChanged: (value){
                      setState(() {
                        repeat = value;
                      });
                    },
                    activeTrackColor: Colors.green,
                    activeColor: Colors.white10,
                  )
                )
              ]
            )
          ),
          Container( // 날짜 설정
              color: Colors.white60 ,
              margin: EdgeInsets.only(top:20, left:30, right:30),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                            child: Text("장소"),
                            style:TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 20),
                            )
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 220),
                        alignment: Alignment.centerRight,
                        child: Switch(
                          value: place,
                          onChanged: (value){
                            setState(() {
                              place = value;
                            });
                          },
                          activeTrackColor: Colors.green,
                          activeColor: Colors.white10,
                        )
                    )
                  ]
              )
          ),
          Container(
              margin: EdgeInsets.only(top:20, left:30, right:30),
              color: Colors.white60,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                            child: Text("날짜"),
                            style:TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 20),
                            )
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 120),
                        child: DropdownButton(
                          value: selectmonth,
                          items: _month.map(
                                (value){
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },

                          ).toList(),
                          onChanged: (value){
                            setState(() {
                              selectmonth = value;
                            });
                          },

                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: DropdownButton(
                          value: selectdate,
                          items: _date1.map(
                                (value){
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (value){
                            setState(() {
                              selectdate = value;
                            });
                          },
                        )
                    ),
                  ]
              )
          ),
          Container( // 시간설정
              margin: EdgeInsets.only(top:20, left:30, right:30),
              color: Colors.white60,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                            child: Text("시간"),
                            style:TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 20),
                            )
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: DropdownButton(
                          value: starttime,
                          items: _time.map(
                                (value){
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (value){
                            setState(() {
                              starttime = value;
                            });
                          },
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        child: DropdownButton(
                          value: startminute,
                          items: _minute.map(
                                (value){
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (value){
                            setState(() {
                              startminute = value;
                            });
                          },
                        )
                    ),
                    Container(
                        width: 15,
                        child: TextButton(
                            child: Text("~"),
                            style:TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 15),
                            )
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: DropdownButton(
                          value: endtime,
                          items: _time.map(
                                (value){
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (value){
                            setState(() {
                              endtime = value;
                            });
                          },
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        child: DropdownButton(
                          value: endminute,
                          items: _minute.map(
                                (value){
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (value){
                            setState(() {
                              endminute = value;
                            });
                          },
                        )
                    ),
                  ]
              )
          ),
      Container( //추가하기 버튼
        margin: EdgeInsets.only(top: 30, right: 30, left: 240),
        alignment: Alignment.centerRight,
        color: Colors.grey,
        child: TextButton(
          child: Text("약속 추가하기"),
            style:TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                )
            )
        )
        ],
      )
    );
  }
}
