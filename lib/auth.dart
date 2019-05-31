import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;


class AuthService{
  
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
  
  Observable<FirebaseUser> user;
  Observable<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  AuthService(){
    user = Observable(_auth.onAuthStateChanged);


  }

  void facebookSignIn() async{
    
  final facebookLogin = FacebookLogin();
  final result = await facebookLogin.logInWithReadPermissions(['email']);
  print(result.status);
 final AuthCredential credential = FacebookAuthProvider.getCredential(
   accessToken: result.accessToken.token
 );
   final FirebaseUser user = await _auth.signInWithCredential(credential);
  print("signed in " + user.displayName);

  /*final token = result.accessToken.token;
  final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
  final profile = jsonDecode(graphResponse.body);  
  print(profile);*/

  }

  Future<FirebaseUser> googleSignIn() async{
    
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

  void signOut(){
    _auth.signOut();
  }

}

final AuthService authService = AuthService();