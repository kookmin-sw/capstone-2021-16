import 'package:app/repository/contents_repository.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ContentsRepository contentsRepository;
  List<Map<String, String>> datas = [];
  String currentMenu; // 초기 데이터는 확정된 약속
  Color btn_1_color;
  Color btn_2_color;
  Color btn_3_color;
  @override
  void initState() {
    super.initState();
    currentMenu = "confirm";
    btn_1_color = Color(0xff18A0FB);
    btn_2_color = Color(0xffffffff);
    btn_3_color = Color(0xffffffff);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    contentsRepository = ContentsRepository(); // didchange에서 데이터 초기화
  }

  _loadContents() {
    return contentsRepository.loadContentsData(currentMenu); // 데이터 불러오기
  }

  _makeDataList(List<Map<String, String>> data) {
    datas = data;
    return ListView.builder(
      // 리스트뷰
      padding: const EdgeInsets.symmetric(vertical: 10), // 전체에 Padiing
      itemBuilder: (BuildContext _context, int index) {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  // width를 꽉 채울 때 사용
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    color: Colors.white,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        Text(
                          datas[index]["title"],
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          datas[index]["location"],
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                        ),
                        Text(datas[index]["date"]),
                      ],
                    ),
                  ),
                )
              ],
            ));
      },
      itemCount: datas.length,
    );
  }

  Widget _listWidget() {
    return FutureBuilder(
        //데이터 API 통신 ( contents_repository에 있는 데이터를 불러옴)
        future: _loadContents(),
        builder: (context, snapshot) {
          //snapshot null check를 해줘야함
          print(snapshot.data);
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator()); //데이터가 안왔을때 로딩처리
          }

          if (snapshot.hasError) {
            // 에러 로직처리
            return Center(
              child: Text("데이터 오류"),
            );
          }

          if (snapshot.hasData) {
            // 데이터가 있을 때만 데이터를 넘겨줌
            return _makeDataList(snapshot.data);
          }

          return Center(
            child: Text("데이터가 없습니다."),
          );
        });
    //
  }

  Widget _categoryWidget(Size size) {
    return Container(
        height: size.height * 0.2, // 상단 카테코리 (확정된 약속, 나의 약속, 약속찾기)
        decoration: BoxDecoration(
          // 박스 Radius 설정
          color: Color(0xffffffff),
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
              height: 10.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // 프로필 들어가야함
                SizedBox(
                  height: 0.0,
                  width: 30.0,
                ),
                Image.asset("assets/images/user.png"),
                SizedBox(
                  height: 0.0,
                  width: 10.0,
                ),
                Text('홍길동님의 프로필'),
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
                    child: Text('확정된 약속'),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30),
                    ),
                    elevation: 0,
                    color: btn_1_color,
                    onPressed: () {
                      setState(() {
                        currentMenu = "confirm";
                        btn_1_color = Color(0xff18A0FB);
                        btn_2_color = Color(0xffffffff);
                        btn_3_color = Color(0xffffffff);
                      });
                    },
                  ),

                  RaisedButton(
                    child: Text('나의 약속'),
                    color: btn_2_color,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30),
                    ),
                    elevation: 0,
                    onPressed: () {
                      setState(() {
                        currentMenu = "mypromise";
                        btn_1_color = Color(0xffffffff);
                        btn_2_color = Color(0xff18A0FB);
                        btn_3_color = Color(0xffffffff);
                      });
                    },
                  ),

                  RaisedButton(
                    child: Text('약속 찾기'),
                    color: btn_3_color,
                    elevation: 0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      setState(() {
                        currentMenu = "searchpromise";
                        btn_1_color = Color(0xffffffff);
                        btn_2_color = Color(0xffffffff);
                        btn_3_color = Color(0xff18A0FB);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

// 빌드 구간
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          _categoryWidget(size), //

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 0.0,
                height: 10.0,
              ),
              Container(
                child: Text('확정된 약속 리스트'),
              )
            ],
          ),

          Expanded(child: _listWidget()), // 리스트
        ],
      )),
    );
  }
}
