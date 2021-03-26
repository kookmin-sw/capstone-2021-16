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
    btn_1_color = Color(0xffffffff);
    btn_2_color = Color(0xff18A0FB);
    btn_3_color = Color(0xff18A0FB);
    txt_1_color = Color(0xff000000);
    txt_2_color = Color(0xffffffff);
    txt_3_color = Color(0xffffffff);
    // dynamic_txt = "확정된 약속 리스트";
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
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  // width를 꽉 채울 때 사용
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              datas[index]["title"],
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              datas[index]["location"],
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            Text(datas[index]["date"]),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text('인원'),
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
      itemCount: datas.length,
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
                Image.asset("assets/images/user.png"),
                SizedBox(
                  height: 0.0,
                  width: 10.0,
                ),
                Text(
                  '홍길동님의 약속',
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 20.0,
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
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
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
            Text(
              "알찬약속",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {}, icon: Image.asset("assets/images/message.png")),
        IconButton(
            onPressed: () {}, icon: Image.asset("assets/images/bell.png"))
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
