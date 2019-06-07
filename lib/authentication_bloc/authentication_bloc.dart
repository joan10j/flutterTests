// BLOC WILL CHECK AND UPDATE USERS AUTHENTICATION STATE IN RESPONSE TO AUTHENTICATIONS EVENTS

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter1_0/repositories/user_repository.dart';
import 'package:flutter1_0/authentication_bloc/bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
    
    final UserRepository _userRepository;

    AuthenticationBloc({@required UserRepository userRespository})
      :assert(userRespository != null),
        _userRepository = userRespository;

    @override
    AuthenticationState get initialState => Uninitialized();

    @override
    Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{
      
      if(event is AppStarted)
        yield* _mapAppStartedToState();
      else if(event is LoggedIn)
        yield* _mapLoggedInToState();
      else if(event is LoggedOut)
        yield* _mapLoggedOutToState();
    }

    Stream<AuthenticationState> _mapAppStartedToState() async*{
      try{
          final isSignedIn = await _userRepository.isSignedIn();
          if(isSignedIn){
            final name = await _userRepository.getUser();
            yield Authenticated(name);
          }
          else yield Unauthenticated();
      }
      catch(_){
        yield Unauthenticated();
      }
    }

    Stream<AuthenticationState> _mapLoggedInToState() async*{
      yield Authenticated(await _userRepository.getUser());
    }

    Stream<AuthenticationState> _mapLoggedOutToState() async*{
      yield Unauthenticated();
      _userRepository.signOut();
    }

  }