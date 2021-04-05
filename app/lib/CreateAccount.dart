import 'dart:async';

import 'package:app/app.dart';
import 'package:app/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({Key key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
//  final AuthService _auth = AuthService();
  String username;
  submitUsername() {
    Timer(Duration(seconds: 4), () {
      Navigator.pop(context, username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextFormField(
          onSaved: (val) => username = val,
        ),
        GestureDetector(
            onTap: submitUsername(),
            child: Container(
              height: 55,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.lightGreenAccent,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text('submit'),
              ),
            ))
      ],
    ));
  }
}
