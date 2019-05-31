import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBase',
      home: Scaffold(
        appBar:AppBar(
          title:Text('Flutterbase'),
          backgroundColor: Colors.amber,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed:()=>authService.googleSignIn(),
                  color:Colors.white,
                  textColor: Colors.black,
                  child: Text('Login with google')
                ,),
                MaterialButton(
                  onPressed:()=>authService.facebookSignIn(),
                  color:Colors.blue,
                  textColor: Colors.black,
                  child: Text('Login with facebook')
                ,)

              ],
            ),
          ),
        )
    );
  }
}


Future<FirebaseUser> _handleSignIn() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = await _auth.signInWithCredential(credential);
  print("signed in " + user.displayName);
  return user;
}

  