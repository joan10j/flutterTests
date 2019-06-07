//** RESPOSIBLE FOR ABSTRACTING THE UNDERLYING IMPLEMENTATION FOR HOW WE AUTHENTICATE AND RETRIVE USER INFORMATION */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class UserRepository{
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin, FacebookLogin facebookLogin})
  //CONSTRUCTOR
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignin ?? GoogleSignIn(),
      _facebookLogin = FacebookLogin();

  Future<FirebaseUser> signInWithGoogle() async{
  //GOOGLE SIGNIN METHOD

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();

  }

  Future<FirebaseUser> signInWithFacebook() async{
  //FACEBOOK SIGIN METHOD
    
    final facebookUser = await _facebookLogin.logInWithReadPermissions(['email']);
    
    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: facebookUser.accessToken.token
    );

    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();

  }

  Future<void> signInWithCredentials(String email, String password) async{
  //SIGININ WITH THEIR OWN CREDENTIALS

    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async{
    //SIGN OUT

    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async{
  //CHECK IF USER IS ALREADY AUTHENTICATED

    final currentUsuer = await _firebaseAuth.currentUser();
    return currentUsuer !=null;
  }

  Future<String> getUser() async{
  //GET USER INFORMATION (actual just email)

    return (await _firebaseAuth.currentUser()).email;
  }

}