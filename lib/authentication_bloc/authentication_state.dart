//** USER AUTHENTICATION STATE can be:
//      -> uninitalized
//      -> authenticated
//      -> unauthenticated

import 'package:equatable/equatable.dart';
//Equatable package is used in order to be able to compare two instances of authenticationstate,
//by default , == return true only if the two objects are the same instance
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable{
  AuthenticationState([List props = const[]]) : super(props);
}

class Uninitialized extends AuthenticationState{
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState{
  final String displayName;

  Authenticated(this.displayName) : super([displayName]);

  @override
  String toString() => 'Authenticated';
}

class Unauthenticated extends AuthenticationState{
  @override
  String toString() => 'Unauthenticated';
}


