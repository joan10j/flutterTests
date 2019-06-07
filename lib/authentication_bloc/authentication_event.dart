//EVENTS THAT AUTHENTICATION BLOC WILL BE REACTING TO
//      -> AppStarted: check if the user is currently authenticated or not
//      -> LoggedIn
//      -> LoggedOut

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable{
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent{
  @override
  String toString() =>'AppStarted';
}

class LoggedIn extends AuthenticationEvent{
  @override
  String toString() =>'LoggedIn';
}

class LoggedOut extends AuthenticationEvent{
  @override
  String toString() =>'LoggedOut';
}