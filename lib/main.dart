import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
      title: 'example',
      home: Scaffold(
        appBar: AppBar(title: Text(
          '16조의 약속',
          textAlign: TextAlign.center,
        )
      ),
        body: MainWidget(),
      ),
  ));
}

class MainWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState(){
    return MainWidgetState();
  }
}

class MainWidgetState extends State<MainWidget>
{
  @override
  Widget build(BuildContext context){
    return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('21.03.01~21.03.06',
              style: TextStyle(
                fontSize:20,
              ),
              textAlign: TextAlign.center,),
            SizedBox(height:5),
            Text('확정된 약속',
              style: TextStyle(
                fontSize:25,
              )
            ),
            SizedBox(height:5),
            DataTable(
              columns: [
                DataColumn(label: Text('날짜')),
                DataColumn(label: Text('시간')),
                DataColumn(label: Text('약속 내용')),
                DataColumn(label: Text('인원')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('03/01')),
                  DataCell(Text('15:00')),
                  DataCell(Text('3.1절 기념방송 시청')),
                  DataCell(Text('03/03')),
                ]),
                DataRow(cells: [
                  DataCell(Text('03/05')),
                  DataCell(Text('14:00')),
                  DataCell(Text('종로에서 점심 약속')),
                  DataCell(Text('02/02')),
                ])
              ]),
            SizedBox(height:10),
            Text('모집중인 약속',
                style: TextStyle(
                  fontSize:25,
                )),
            SizedBox(height:5),
            DataTable(
                columns: [
                  DataColumn(label: Text('날짜')),
                  DataColumn(label: Text('시간')),
                  DataColumn(label: Text('약속 내용')),
                  DataColumn(label: Text('인원')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('03/05')),
                    DataCell(Text('12:00')),
                    DataCell(Text('무한리필 고기 조지실분')),
                    DataCell(Text('01/03')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('03/06')),
                    DataCell(Text('17:00')),
                    DataCell(Text('운동장에서 풋살하실')),
                    DataCell(Text('09/12')),
                  ])
                ])
          ],
      );
  }
}
