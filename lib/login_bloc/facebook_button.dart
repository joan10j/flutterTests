import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter1_0/login_bloc/bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FacebookButton extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(30.0) ),
        icon: Icon(FontAwesomeIcons.facebook,color: Colors.white,),
        onPressed: (){
          BlocProvider.of<LoginBloc>(context).dispatch(LoginWithFacebookPressed());
        },
        label: Text('Sign in with Facebook',style: TextStyle(color: Colors.white),),
        color: Colors.blueAccent,
    );
  }
}