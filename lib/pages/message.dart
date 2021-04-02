import 'package:flutter/material.dart';

class Message {
  final String name;
  final String message;

  Message(this.name, this.message);
}

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {

  List<Message> notes = [
    Message('이헌수', '참가해요'),
    Message('함석민', '참가해요'),
    Message('김현서', '불참해요'),
    Message('이선용', '불참해요'),
    Message('이주윤', '참가해요'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,
        body:
        ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {},
                  title: Text(
                      notes[index].name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/512x512/plain/user.png'),
                  ),
                  trailing: Text(
                      notes[index].message,
                      style: TextStyle(
                        fontSize: 20,
                      )
                  ),
                ),
              );
            }
        )
    );
  }
}

void main() {
  runApp(MaterialApp(home: MessageList()));
}
