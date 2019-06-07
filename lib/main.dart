import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter1_0/screens/home_screen.dart';
import 'package:flutter1_0/screens/splash_screen.dart';
import 'package:flutter1_0/simple_bloc_delegate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter1_0/authentication_bloc/bloc.dart';
import 'repositories/user_repository.dart';
import 'screens/login_form.dart';
import 'screens/login_screen.dart';


main(){
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}


//APP STATEFUL BECAUSE IT WILL MANAGE OUR AUTHENTICATION BLOC
class App extends StatefulWidget{
  State<App> createState() => _AppState();
}

class _AppState extends State<App>{
  final UserRepository _userRepository = UserRepository(); //REPOSITORY FOR THE USER
  AuthenticationBloc _authenticationBloc;

  @override
  void initState(){
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRespository: _userRepository); // ON INIT STATE WE INJECT USER RESPOSITORY TO OUR BLOC
    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context){
    return BlocProvider( // MAKE SURE OUR AUTHENTICATIONBLOC INSTANCE IS AVALIABLE TO THE ENTIRE WIDGET
      bloc: _authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder( // BLOC BUILDER TO RENDER UI BASED ON AUTHENTICATIONBLOC 
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if(state is Unauthenticated) return LoginScreen(userRepository: _userRepository);
            if(state is Uninitialized) return SplashScreen();
            if(state is Authenticated) return HomeScreen(name: state.displayName,);

          },
        )
      ),
    );
  }

  @override
  void dispose(){
    _authenticationBloc.dispose();
    super.dispose();
  }

}















































/*import 'package:flutter/material.dart';
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
*/