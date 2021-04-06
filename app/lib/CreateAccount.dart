import 'dart:async';

import 'package:app/app.dart';
import 'package:app/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final userReference = FirebaseFirestore.instance.collection('users');
final GoogleSignIn googleSignIn = new GoogleSignIn();
GoogleSignInAccount currentUser;
// FirebaseUesr user;

class CreateAccount extends StatefulWidget {
  CreateAccount({Key key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String username;
  bool isSigned = false;
  String uid;
  final myController = TextEditingController();
  void submitUsername() {
    username = myController.text;
    Timer(Duration(seconds: 4), () {
      Navigator.pop(context, username);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isSigned) {
      return Scaffold(
          body: Center(
        child: Column(
          children: [
            TextField(
              controller: myController,
            ),
            RaisedButton(
              child: Text(
                'submit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30),
              ),
              onPressed: () {
                submitUsername();
              },
            ),
          ],
        ),
      ));
    } else {
      return App();
    }
  }
}
