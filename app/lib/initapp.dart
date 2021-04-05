import 'package:app/pages/login.dart';
import 'package:app/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class initApp extends StatelessWidget {
  const initApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Firebase load fail"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Login();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
