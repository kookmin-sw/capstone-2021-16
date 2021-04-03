import 'package:app/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();
final userReference = FirebaseDatabase.instance.reference().child('users');

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isSignedIn = false;
  GoogleSignInAccount _currentUser;

  Future<void> _hadleSignin() async {
    try {
      print('구글 signIn');
      // await _googleSignIn.signIn();
      _googleSignIn.signIn().then((GoogleSignInAccount account) async {
        GoogleSignInAuthentication auth = await account.authentication;
        print(account.id);
        print(account.email);
        print(account.displayName);
        print(account.photoUrl);
      });
    } catch (error) {
      print(error);
    }
  }

  Widget googleSignButton() {
    return GestureDetector(
      onTap: () {
        print('구글 로그인 버트느');
        _hadleSignin();
      },
      child: Text(
        'Sign In With Google',
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      // Firebase 초기화
      print('complete');
      setState(() {});
    });
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      // 기존 사용자가 정보 변경되었는지
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        // 기존에 로그인 했었다면 app으로 이동
        print(_currentUser);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => App()),
            (Route<dynamic> route) => false);
      }
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: googleSignButton(),
        ),
      ),
    );
  }
}
