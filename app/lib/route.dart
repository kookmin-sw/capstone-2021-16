import 'package:app/app.dart';
import 'package:app/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class routePage extends StatefulWidget {
  routePage({Key key}) : super(key: key);

  @override
  _routePageState createState() => _routePageState();
}

class _routePageState extends State<routePage> {
//  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (!snapshot.hasData) {
            return Login();
          } else {
            return App();
          }
        });
  }
}
