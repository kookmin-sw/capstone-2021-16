import 'package:firebase_database/firebase_database.dart';

class Memo {
  String key;
  String title;
  String content;
  String createTime;
  String uid;
  bool repeat;
  String startTime;
  String endTime;
  int num;


  // Memo(this.title, this.content, this.createTime, this.uid, this.repeat, this.meetdate, this.deadline, this.num);
  Memo(this.title, this.content, this.startTime, this.endTime, this.createTime);

  Memo.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value['title'],
        content = snapshot.value['content'],
        startTime = snapshot.value['startTime'],
        endTime = snapshot.value['endTime'],
        createTime = snapshot.value['createTime'];
  // num = snapshot.value['num'],
  // uid = snapshot.value['uid'];

  toJson() {
    return {
      '약속 이름': title,
      '약속 내용': content,
      '약속 시작시간': startTime,
      '약속 종료시간': endTime,
      '약속 생성시간': createTime,
      // 'uid': uid,
      // 'repeat': repeat,
      // 'num': num,
    };
  }
}
