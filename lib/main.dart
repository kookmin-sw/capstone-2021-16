import 'package:flutter/material.dart';
import 'package:calendar/add.dart';
import 'package:calendar/home.dart';
import 'package:calendar/appointment.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Calender(),
        '/add': (context) => Add(),
      },
  ));
}