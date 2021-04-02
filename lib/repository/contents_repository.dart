// 데이터 담당을 위한 클래스 , 서버에서 데이트를 받아옴

class ContentsRepository {
  Map<String, dynamic> datas = {
    "confirm": [
      {"title": "친구 약속", "location": "서울 홍대", "date": "2021/05/20"},
      {"title": "스터디 모임", "location": "서울 신촌", "date": "2021/06/10"},
      {"title": "누구랑 약속", "location": "경기 고양", "date": "2021/05/20"},
      {"title": "동창회", "location": "경기 의정부", "date": "2021/05/20"},
    ],
    "mypromise": [
      {"title": "친구 약속2", "location": "서울 홍대2", "date": "2021/05/20"},
      {"title": "스터디 모임2", "location": "서울 신촌2", "date": "2021/06/10"},
      {"title": "누구랑 약속2", "location": "경기 고양2", "date": "2021/05/20"},
      {"title": "동창회2", "location": "경기 의정부2", "date": "2021/05/20"},
    ],
    "searchpromise": [
      {"title": "친구 약속3", "location": "서울 홍대3", "date": "2021/05/20"},
      {"title": "스터디 모임3", "location": "서울 신촌3", "date": "2021/06/10"},
      {"title": "누구랑 약속3", "location": "경기 고양3", "date": "2021/05/20"},
      {"title": "동창회3", "location": "경기 의정부3", "date": "2021/05/20"},
    ],
  };

  Future<List<Map<String, String>>> loadContentsData(String menu) async {
    // API 통신 location값을 보내주면서 비동기 처리
    await Future.delayed(Duration(microseconds: 1000)); // setTimeOut
    // throw Exception();
    return datas[menu];
  }
}
