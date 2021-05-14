import 'package:flutter/material.dart';

class Agendas {
  final List date;
  final String title;
  final List people;

  Agendas(this.date, this.title, this.people);
}
class AgendasList extends StatefulWidget {
  @override
  _AgendasListState createState() => _AgendasListState();
}

class _AgendasListState extends State<AgendasList> {
  static List<Agendas> notes = [
    Agendas([4, 28], "운동", [3, 5]),
    Agendas([4, 29], "이벤트", [1, 3]),
    Agendas([4, 30], "소모임", [1, 3]),
  ];

  final notes_temp = new List<Agendas>.from(notes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget> [
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
                    onTap: () { setState(() {
                      notes_temp.clear();
                      notes_temp.insertAll(0, notes);
                      notes_temp.removeWhere((item) => item.title != '운동');
                    });
                    }
                ),
                ListTile(
                    title: Text('이벤트'),
                    onTap: () { setState(() {
                      notes_temp.clear();
                      notes_temp.insertAll(0, notes);
                      notes_temp.removeWhere((item) => item.title != '이벤트');
                    });
                    }
                ),
                ListTile(
                    title: Text('소모임'),
                    onTap: () {
                      setState(() {
                        notes_temp.clear();
                        notes_temp.insertAll(0, notes);
                        notes_temp.removeWhere((item) => item.title != '소모임');
                      });
                    }
                ),
                ListTile(
                    title: Text('모두'),
                    onTap: () {
                      setState(() {
                        notes_temp.clear();
                        notes_temp.insertAll(0, notes);
                      });
                    }
                ),
              ]
          )
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: notes_temp.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: ListTile(
                onTap: () {},
                title: Text(
                    notes_temp[index].title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff18A0FB),
                      fontWeight: FontWeight.bold,
                    )
                ),
                leading: Text.rich(
                  TextSpan(
                      text: notes_temp[index].date[0].toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff18A0FB),
                      ),
                      children: <TextSpan> [
                        TextSpan(text: '/'),
                        TextSpan(text: notes_temp[index].date[1].toString())
                      ]
                  ),
                ),
                trailing: Text.rich(
                  TextSpan(
                      text: notes_temp[index].people[0].toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan> [
                        TextSpan(text: '/'),
                        TextSpan(text: notes_temp[index].people[1].toString())
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
  runApp(MaterialApp(home: AgendasList()));
}
