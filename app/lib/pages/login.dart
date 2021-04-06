import 'package:app/CreateAccount.dart';
import 'package:app/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();
final userReference = FirebaseFirestore.instance.collection('users');
// final userReference = FirebaseDatabase.instance.reference().child('users');

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isSignedIn = false;
  GoogleSignInAccount _currentUser;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await saveUserInfoToFirebase(googleUser);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  saveUserInfoToFirebase(googleUser) async {
    final GoogleSignInAccount gCurrentUser = googleUser;
    print(gCurrentUser);
    DocumentSnapshot documentSnapshot =
        await userReference.doc(gCurrentUser.id).get();
    if (!documentSnapshot.exists) {
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));
      userReference.doc(gCurrentUser.id).set({
        'id': gCurrentUser.id,
        'profileNmae': gCurrentUser.displayName,
        'username': username,
        'url': gCurrentUser.photoUrl,
        'email': gCurrentUser.email,
      });
    }
  }

  Widget googleSignButton() {
    return GestureDetector(
      onTap: () {
        print('구글 로그인 버트느');
        signInWithGoogle();
        // saveUserInfoToDatabase();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 최상단에 있는 것
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return App();
          } else {
            return Scaffold(
              body: Center(
                child: googleSignButton(),
              ),
            );
          }
        },
      ),
    );
  }
}
