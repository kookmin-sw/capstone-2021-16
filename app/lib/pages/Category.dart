import 'package:flutter/material.dart';

class agendas {
  final List date;
  final String title;
  final List people;

  agendas(this.date, this.title, this.people);
}

class agendasList extends StatefulWidget {
  @override
  _agendasListState createState() => _agendasListState();
}

class _agendasListState extends State<agendasList> {

  List<agendas> notes = [
    agendas([4, 28], "운동", [3, 5]),
    agendas([4, 29], "에빈트", [1, 3]),
    agendas([4, 30], "소모임", [1, 3]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
              padding: EdgeInsets.zero,
              children: const <Widget> [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xff18A0FB),
                  ),
                  child: Text(
                      '카테고리',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24
                      )
                  ),
                ),
                ListTile(
                  title: Text('운동'),
                ),
                ListTile(
                  title: Text('이벤트'),
                ),
                ListTile(
                  title: Text('소모임'),
                ),
              ]
          )
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {},
                title: Text(
                    notes[index].title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff18A0FB),
                      fontWeight: FontWeight.bold,
                    )
                ),
                leading: Text.rich(
                  TextSpan(
                      text: notes[index].date[0].toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff18A0FB),
                      ),
                      children: <TextSpan> [
                        TextSpan(text: '/'),
                        TextSpan(text: notes[index].date[1].toString())
                      ]
                  ),
                ),
                trailing: Text.rich(
                  TextSpan(
                      text: notes[index].people[0].toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan> [
                        TextSpan(text: '/'),
                        TextSpan(text: notes[index].people[1].toString())
                      ]
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: agendasList()));
}