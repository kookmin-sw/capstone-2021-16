class Content{
  String title;
  String content;
  String date;
  String time;
  int id;

  Content({this.title, this.content, this.date , this.time, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'title': title,
      'content': content,
      'date': date,
      'time': time,
    };
  }
}